extends Node2D

var positionScene = preload("res://scenes/positions/position_scene.tscn");
var gameObjectScene = preload("res://scenes/GameObjects/gameObject_scene.tscn");
var beingScene = preload("res://scenes/being_scene.tscn");
var populationScene = preload("res://scenes/GameObjects/population_scene.tscn");
var consumableScene = preload("res://scenes/GameObjects/consumable_scene.tscn");

var elapsedTime = 0.0;
var stepDuration = 0.2;

var dayLength = 60;
var dayProgression = 0;
var day = 0;

var spawnCooldDown = 1;

var population: Population;

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

var gameDataLabel: Label:
	get:
		if gameDataLabel == null:
			gameDataLabel = get_tree().get_first_node_in_group("GameDataLabel");
		return gameDataLabel;

func _process(delta):
	elapsedTime += delta;
	UpdateHud();

	if elapsedTime >= stepDuration:
		spawnCooldDown += 1;
		elapsedTime = 0.0;
		if spawnCooldDown >= 500:
			spawnCooldDown = 0;
			SpawnGameObjects();
		dayProgression += 1;
		if dayProgression >= dayLength:
			dayProgression = 0;
			day += 1;
			
	
func UpdateHud():
	if selectedBeing != null:
		labelNode.text = selectedBeing.UpdateBeingLabel();
	
	var gameDataString = "";
	gameDataString += "Day: " + str(day);
	gameDataString += "\nBeings: " + str(population.beings.size());

	gameDataLabel.text = gameDataString;


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
	population = populationScene.instantiate();
	get_tree().get_root().add_child.call_deferred(population);

func SpawnGameObjects() -> void:
	for n in 10:
		var newGameObject = consumableScene.instantiate();
		if randf() > 0.5:
			newGameObject.AddToResources(ResourceData.new("Food", 10));
			newGameObject.type = "Food"
		else:
			newGameObject.AddToResources(ResourceData.new("Wood", 10));
			newGameObject.type = "Wood"
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newGameObject);

func SpawnBeings() -> void:
	for n in 2:
		var newBeing = beingScene.instantiate();
		newBeing.population = population;
		positionsNode.get_children()[randi_range(0, positionsNode.get_child_count() - 1)].add_child(newBeing);
		population.beings.append(newBeing);
		newBeing.birthday = day;
		newBeing.type = "Being";

	#print(p.beings.size())

func CreateNewBeing(parentA: Being, parentB: Being = null):
	##at some point parents will influence how the child becomes
		var newBeing = beingScene.instantiate();
		newBeing.population = parentA.population;
		positionsNode.get_children()[parentA.GetPositionNodeIndex()].add_child(newBeing);
		population.beings.append(newBeing);
		newBeing.birthday = day;
		newBeing.type = "Being"

func CreateNewGameObject(type: String, position: int) -> GameObject:
	var newObject = gameObjectScene.instantiate();
	newObject.type = type;
	positionsNode.get_children()[position].add_child(newObject);
	return newObject;