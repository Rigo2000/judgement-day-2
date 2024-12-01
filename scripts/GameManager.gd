extends Node2D

var positionScene = preload("res://scenes/positions/position_scene.tscn");
var gameObjectScene = preload("res://scenes/GameObjects/gameObject_scene.tscn");
var beingScene = preload("res://scenes/being_scene.tscn");
var population = preload("res://scenes/GameObjects/population_scene.tscn");

var elapsedTime = 0.0;
var stepDuration = 0.2;

var spawnCooldDown = 1;

var p: Population;

var selectedBeing: Being;

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

var labelNode: Label:
	get:
		if labelNode == null:
			labelNode = get_tree().get_first_node_in_group("LabelNode");
		return labelNode;

func _process(delta):
	elapsedTime += delta;
	UpdateHud();

	if elapsedTime >= stepDuration:
		spawnCooldDown += 1;
		elapsedTime = 0.0;
		if spawnCooldDown >= 10:
			spawnCooldDown = 0;
			SpawnGameObjects();
	
	
func UpdateHud():
	if selectedBeing != null:
		labelNode.text = selectedBeing.UpdateBeingLabel();

func _ready() -> void:
	if true:
		for n in 100:
			var newPosition: Node2D = positionScene.instantiate()
			positionsNode.add_child(newPosition);
			newPosition.position = Vector2(n * 20, 200)

		SpawnPopulation();
		SpawnGameObjects();
		SpawnBeings();

func SpawnPopulation():
	p = population.instantiate();
	get_tree().get_root().add_child.call_deferred(p);
	var newGameObject = GameObject.new();
	newGameObject.type = "townSquare";
	p.buildings.append(newGameObject)
	positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newGameObject);

func SpawnGameObjects() -> void:
	for n in 4:
		var newGameObject = gameObjectScene.instantiate();
		newGameObject.type = "Food";
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newGameObject);

func SpawnBeings() -> void:
	for n in 2:
		var newBeing = beingScene.instantiate();
		newBeing.population = p;
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newBeing);
		p.beings.append(newBeing);

	#print(p.beings.size())

func CreateNewBeing(parentA: Being, parentB: Being = null):
	##at some point parents will influence how the child becomes
		var newBeing = beingScene.instantiate();
		newBeing.population = parentA.population;
		positionsNode.get_children()[parentA.GetPositionNodeIndex()].add_child(newBeing);
		p.beings.append(newBeing);

func CreateNewGameObject(type: String, position: int) -> GameObject:
	var newObject = gameObjectScene.instantiate();
	newObject.type = "House";
	positionsNode.get_children()[position].add_child(newObject);
	return newObject;