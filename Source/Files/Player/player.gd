extends CharacterBody2D

# Movement
var base_speed = 100;
var move_speed: float = 100;
var starting_direction: Vector2 = Vector2(0, 1);

# Animation
@onready var animation_tree = $AnimationTree;
@onready var state_machine = animation_tree.get("parameters/playback");

# Pause menu
@onready var pause_menu = $"Pause menu";
var paused = false;


# Heatlh
@onready var healthBar = $"Heath Bar Canvas/Player Health Bar";
var maxHealth = 100;
var currentHealth = 100;

# Damage indicator
@onready var damageIndicatorOrigin = $DamageIndicatorOrigin;

# Dash
var dashBool = false;
var canDash = true;

func _ready():
	Global.playerNode = self;
	Update_animation_parameters(starting_direction);
	
	Set_health_bar();
	healthBar.max_value = maxHealth;

func _physics_process(_delta):
	
	if (!paused):
		# get input direction
		var input_direction = Vector2 (
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		Update_animation_parameters(input_direction);
		
		# update vel, normalized da je diagonalno premikanje enako hitro kot navadno
		velocity = input_direction.normalized() * move_speed;
		
		# premakni 
		move_and_slide();
		
		pick_new_state();
		
		if (Input.is_action_just_pressed("dash")):
			Dash();
		
		
		$Info/Text.text = str("\nLevel: ", Global.lvlNum, "\nScore: ", Global.score);
	
	if (Input.is_action_just_pressed("Pause")):
		PauseMenu();


# Animation
func Update_animation_parameters(move_input: Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input);
		animation_tree.set("parameters/Idle/blend_position", move_input);
		animation_tree.set("parameters/Swing/blend_position", move_input);

func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk");
	else:
		state_machine.travel("Idle");
	
	if (Input.is_action_just_pressed("melee")):
		state_machine.travel("Swing");


# Pause menu
func PauseMenu():
	if (paused):
		pause_menu.hide();
		Engine.time_scale = 1;
	else:
		pause_menu.show();
		Engine.time_scale = 0;
	paused = !paused;


# Health bar
func Set_health_bar():
	healthBar.value = currentHealth;


# Dash
func Dash():
	if (!dashBool && canDash):
		base_speed = move_speed;
		move_speed = base_speed * 2.5;
		dashBool = true;
		canDash = false;
		$DashDuration.start();
		$DashCooldown.start();
		await $DashCooldown.timeout;

func _on_dash_cooldown_timeout():
	canDash = true;

func _on_dash_duration_timeout():
	move_speed = base_speed;
	dashBool = false;


# Combat
func _on_sword_hitbox_area_entered(area):
	if area.is_in_group("Hurtbox"):
		area.get_parent().TakeDamage(20);
	#$AnimatedSprite2D/SwordHitbox/HitboxDown.disabled = true;
	#$AnimatedSprite2D/SwordHitbox/HitboxUp.disabled = true;
	#$AnimatedSprite2D/SwordHitbox/HitboxRight.disabled = true;
	#$AnimatedSprite2D/SwordHitbox/HitboxLeft.disabled = true;

# Damage
func TakeDamage(damageValue: int):
	
	# current health - damage value <= 0
	if (currentHealth <= 0):
		self.queue_free();
		get_tree().change_scene_to_file("res://Files/Interface/Menus/game_over.tscn");
	else:
		currentHealth -= damageValue;
		DamageIndicator.DisplayNumber(damageValue, damageIndicatorOrigin.global_position);
		Set_health_bar();
	
	if (currentHealth <= 0):
		self.queue_free();
		get_tree().change_scene_to_file("res://Files/Interface/Menus/game_over.tscn");
