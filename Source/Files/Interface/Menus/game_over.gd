extends Control


func _on_main_menu_pressed():
	Global.save();
	Global.restart();
	get_tree().change_scene_to_file("res://Files/Interface/Menus/main_menu.tscn");

func _on_quit_pressed():
	Global.save();
	get_tree().quit();
