extends Node2D
#
#var enemyNode = preload("res://Files/NPC/enemy.tscn");
#var enemyArray : Array[Vector2i];
#var nextLevelNode = preload("res://Files/Levels/next_level.tscn");
#var nextLvlShown = false;
#
#func _ready():
	#SpawnEnemies();
#
#func SpawnEnemies():
	#while enemyArray.size() < 5:
		#var enemy = enemyNode.instantiate();
		#enemy.position.x = randi_range(0, 300);
		#enemy.position.y = randi_range(0, 150);
#
		#var tempPos = Vector2i(enemy.position.x, enemy.position.y);
#
		#var exists = false;
		#for j in range(enemyArray.size()):
			#if abs(enemyArray[j] - tempPos) <= Vector2i(30, 30):
				#exists = true;
				#break;
		#
		#if (exists == false):
			#enemyArray.append(tempPos);
			#add_child(enemy);
#
#func _physics_process(_delta):
	#if (get_tree().get_nodes_in_group("Enemy").size() == 0 && nextLvlShown == false):
		#var nextLevel = nextLevelNode.instantiate();
		#nextLevel.position.x = 450;
		#nextLevel.position.y = 110;
		#
		#add_child(nextLevel);
		#nextLvlShown = true;
