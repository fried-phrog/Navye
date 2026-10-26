extends Node

@onready var fire = $Fire/FireShape;

func _physics_process(_delta):
	
	if (Input.is_action_just_pressed("fire")):
		if (fire.disabled == true):
			fire.visible = !fire.visible;
			fire.disabled = false;
			$Fire/FireShape/FireSprite.play("default");
			$Fire/FireShowTimer.start();
	
	if (Input.is_action_just_pressed("strength")):
		self.get_parent().move_speed = self.get_parent().base_speed + 50;
		
		$StrengthTimer.start();
		await $StrengthTimer.timeout;
		
		self.get_parent().move_speed = 100;

func _on_fire_show_timer_timeout():
	fire.visible = !fire.visible;
	fire.disabled = true;

func _on_fire_area_entered(area):
	if area.is_in_group("Hurtbox"):
		if fire.visible:
			area.get_parent().TakeDamage(5, true);
