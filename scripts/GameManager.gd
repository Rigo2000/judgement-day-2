extends Node2D

var positionScene = preload("res://scenes/positions/position_scene.tscn");
var gameObjectScene = preload("res://scenes/GameObjects/gameObject_scene.tscn");
var beingScene = preload("res://scenes/being_scene.tscn");

var elapsedTime = 0.0;
var coolDown = 10.0;

var p: Population;

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

func _process(delta):
	elapsedTime += delta;

	if elapsedTime >= coolDown:
		elapsedTime = 0.0;
		SpawnGameObjects();


func _ready() -> void:
	if true:
		for n in 20:
			var newPosition = positionScene.instantiate()
			positionsNode.add_child(newPosition);

		SpawnPopulation();
		SpawnGameObjects();
		SpawnBeings();

func SpawnPopulation():
	p = Population.new();
	var newGameObject = GameObject.new();
	p.buildings["townSquare"] = newGameObject;
	positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newGameObject);

func SpawnGameObjects() -> void:
	for n in 4:
		var newGameObject = gameObjectScene.instantiate();
		newGameObject.type = "Food";
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newGameObject);

func SpawnBeings() -> void:
	for n in 1:
		var newBeing = beingScene.instantiate();
		newBeing.population = p;
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newBeing);
