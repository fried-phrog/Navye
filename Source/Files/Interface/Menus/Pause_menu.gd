extends Control

@onready var player = $"../";

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Files/Interface/Menus/main_menu.tscn");
	player.paused = false;
	Engine.time_scale = 1;
	Global.loadScore();
	Global.restart();

func _on_resume_pressed():
	player.PauseMenu();
