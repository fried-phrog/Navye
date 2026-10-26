extends Node

# levels
var loopNum = 0;
var lvlNum = 0;

# score
var score = 0;
var multiplier  = 1;
var scorePath = "user://scores.save";

# player
var playerNode = null;

func DamagePlayer(damageValue: int):
	if (playerNode):
		playerNode.TakeDamage(damageValue);

func GameWin():
	get_tree().change_scene_to_file("res://Files/Interface/Menus/game_win.tscn");

func save():
	if (checkIfHi()):
		var file = FileAccess.open(scorePath, FileAccess.WRITE);
		file.store_string(str(score));
		file.close();

func loadScore():
	var file = FileAccess.open(scorePath, FileAccess.READ);
	
	if (file == null):
		return 0;
	else:
		return file.get_as_text();

func checkIfHi():
	var file = FileAccess.open(scorePath, FileAccess.READ);
	
	if (file == null):
		return true;
	elif (file.get_as_text().to_int() < score):
		return true;
	else:
		return false;

func restart():
	loopNum = 0;
	lvlNum = 0;
	score = 0;
	multiplier = 1;
	scorePath = "user://scores.save";
	playerNode = null;
