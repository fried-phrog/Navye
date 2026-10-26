extends Area2D

func _physics_process(_delta):
	$AnimatedSprite2D.play("default");

func _on_body_entered(body):
	print("entered");
	if (body.is_in_group("Player")):
		get_tree().change_scene_to_file.bind("res://Files/Levels/boss_room.tscn").call_deferred();
