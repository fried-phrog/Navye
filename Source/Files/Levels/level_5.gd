extends Node2D

var enemyNode = preload("res://Files/NPC/enemy.tscn");
var enemyArray : Array[Vector2i];

# Doors
var loopNode = preload("res://Files/Levels/go_loop.tscn");
var bossLevelNode = preload("res://Files/Levels/go_boss.tscn");
var loopShown = false;

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

func _physics_process(_delta):
	if (get_tree().get_nodes_in_group("Enemy").size() == 0 && loopShown == false):
		var temp = loopNode.instantiate();
		temp.position.x = 230;
		temp.position.y = 250;
		add_child(temp);
		
		temp = bossLevelNode.instantiate();
		temp.position.x = 270;
		temp.position.y = 250;
		add_child(temp);
		
		loopShown = true;
