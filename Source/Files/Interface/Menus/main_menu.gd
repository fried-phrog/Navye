extends Control

func _ready():
	$MarginContainer/HBoxContainer/VerticalBoxContainer/Score.text = str("HISCORE: ", Global.loadScore());
	print("LOADED: ", Global.loadScore());

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Files/Levels/game.tscn");

func _on_quit_pressed():
	get_tree().quit();
