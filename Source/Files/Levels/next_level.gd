extends Area2D

func _physics_process(_delta):
	$AnimatedSprite2D.play("default");

func _on_body_entered(body):
	if (body.is_in_group("Player")):
		var currentScene = get_tree().current_scene.scene_file_path;
		var nextLevelNum = currentScene.to_int() + 1;
		
		var nextLevelPath = "res://Files/Levels/level_" + str(nextLevelNum) + ".tscn";
		get_tree().change_scene_to_file.bind(nextLevelPath).call_deferred();
