extends Area2D

func _physics_process(_delta):
	$AnimatedSprite2D.play("default"); 

func _on_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene_to_file.bind("res://Files/Levels/level_1.tscn").call_deferred();
		Global.loopNum += 1;
