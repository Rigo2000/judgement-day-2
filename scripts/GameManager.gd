extends Node2D

var positionScene = preload("res://scenes/positions/position_scene.tscn");
var gameObjectScene = preload("res://scenes/GameObjects/gameObject_scene.tscn");
var beingScene = preload("res://scenes/being_scene.tscn");

var qm: QuestManager:
	get:
		if qm == null:
			qm = get_tree().get_first_node_in_group("QuestManager");
		return qm;


var positionsNode: Node2D:
	get:
		if positionsNode == null:
			positionsNode = get_tree().get_first_node_in_group("PositionsNode");
		return positionsNode;

func _ready() -> void:
	print("sdaf")
	var tries = 0;

	# while positionsNode == null && qm == null:
	# 	tries += 1;
	# 	if tries > 100:
	# 		break ;
	# 	else:
	# 		print("waitin");


	if true:
		print("not waiting");
		for n in 20:
			var newPosition = positionScene.instantiate()
			positionsNode.add_child(newPosition);
			print("added position")

		SpawnGameObjects();
		SpawnBeings();

func SpawnGameObjects() -> void:
	for n in 10:
		var newGameObject = gameObjectScene.instantiate();
		newGameObject.type = "FoodType";
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newGameObject);

func SpawnBeings() -> void:
	for n in 5:
		var newBeing = beingScene.instantiate();
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newBeing);
