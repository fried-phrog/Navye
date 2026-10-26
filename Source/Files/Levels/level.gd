extends Node2D

var enemyNode = preload("res://Files/NPC/enemy.tscn");
var enemyArray : Array[Vector2i];
var nextLevelNode = preload("res://Files/Levels/next_level.tscn");
var nextLvlShown = false;

func _ready():
	Global.lvlNum += 1;
	Global.multiplier = (Global.lvlNum + Global.loopNum);
	print(Global.lvlNum, Global.loopNum);
	SpawnEnemies();

func SpawnEnemies():
	while enemyArray.size() < (5 + Global.lvlNum - 1):
		var enemy = enemyNode.instantiate();
		enemy.position.x = randi_range(10, 490);
		enemy.position.y = randi_range(10, 490);
		enemy.health = enemy.health + (10 * Global.multiplier);

		var tempPos = Vector2i(enemy.position.x, enemy.position.y);

		var exists = false;
		for j in range(enemyArray.size()):
			if abs(enemyArray[j] - tempPos) <= Vector2i(30, 30):
				exists = true;
				break;
		
		if (exists == false):
			enemyArray.append(tempPos);
			add_child(enemy);
			print(enemy.health, '\n'); 

func _physics_process(_delta):
	if (get_tree().get_nodes_in_group("Enemy").size() == 0 && nextLvlShown == false):
		var nextLevel = nextLevelNode.instantiate();
		nextLevel.position.x = 250;
		nextLevel.position.y = 250;
		
		add_child(nextLevel);
		nextLvlShown = true;
