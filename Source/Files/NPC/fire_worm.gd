extends CharacterBody2D

# Movement
var speed = 25;
@onready var player = null;

# Health and combat
var health = 100;
var canDealDamage = false;
var isDying = false;

# Damage indicator
@onready var damageIndicatorOrigin = $DamageIndicatorOrigin;

func _ready():
	health = 100 + (20 * Global.multiplier);

func _physics_process(_delta):
	
	# Ce player pride dovolj blizu, se mu zacne priblizevat
	if (health > 0):
		velocity = Vector2.ZERO;
		if (player != null && position.distance_to(player.position) > 30): 
			velocity = position.direction_to(player.position).normalized() * speed;
			$AnimatedSprite2D.play("walk");
			
			if (player.position.x - position.x < 0):
				$AnimatedSprite2D.flip_h = true;
			else:
				$AnimatedSprite2D.flip_h = false;
			
		elif (!canDealDamage):
			$AnimatedSprite2D.play("idle");
	
	move_and_slide();
	

func _on_detection_area_body_entered(body):
	if (body.is_in_group("Player")):
		player = body;


func _on_detection_area_body_exited(body):
	if (body.is_in_group("Player")):
		player = null;


# Combat: player -> enemy
func TakeDamage(damageValue: int, _burning = false):

	if (isDying):
		return;
	
	if (health <= 0):
		isDying = true;
		$AnimatedSprite2D.play("death");
		await $AnimatedSprite2D.animation_finished;
		Global.score += 10 * Global.multiplier;
		Global.GameWin();
		self.queue_free();
	else:
		health -= damageValue;
		DamageIndicator.DisplayNumber(damageValue, damageIndicatorOrigin.global_position);
		$AnimatedSprite2D.play("hit");
		await $AnimatedSprite2D.animation_finished;
	
	if (health <= 0):
		isDying = true;
		$AnimatedSprite2D.play("death");
		await $AnimatedSprite2D.animation_finished;
		Global.score += 20 * Global.multiplier;
		Global.GameWin();
		self.queue_free();

# Combat: enemy -> player
func _on_hitbox_area_entered(area):
	if (area.is_in_group("PlayerHurtbox")):
		canDealDamage = true;
		$Hitbox/AttackCooldown.start();


func _on_hitbox_area_exited(area):
	if (area.is_in_group("PlayerHurtbox")):
		canDealDamage = false;
		$Hitbox/AttackCooldown.stop();


func _on_attack_cooldown_timeout():
	if (canDealDamage == true && health > 0):
		Global.DamagePlayer(20);
		$AnimatedSprite2D.play("attack");
		await $AnimatedSprite2D.animation_finished;
