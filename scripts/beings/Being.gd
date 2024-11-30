class_name Being extends GameObject;

var hunger: int;
var health: int;
var age: int;
var sleep: int;
var devotion: int;

var pregnancy;

var population: Population;

var currentState: BeingState = null;
var states = {};

var reach: int = 0;
var viewDistance: int = 5;

var pos: int:
	get:
		return GetPositionNodeIndex();

var chainedTask = [];
		
var coolDown: float = 0.2;
var elapsedTime;

func _ready() -> void:
	hunger = 20;
	elapsedTime = 0.0;
	states["IdleState"] = preload("res://scripts/beings/states/IdleState.gd").new();
	states["EatState"] = preload("res://scripts/beings/states/EatState.gd").new();
	states["MoveState"] = preload("res://scripts/beings/states/MoveState.gd").new();
	states["GatherState"] = preload("res://scripts/beings/states/GatherState.gd").new();
	states["DeliverState"] = preload("res://scripts/beings/states/DeliverState.gd").new();
	states["MateState"] = preload("res://scripts/beings/states/MateState.gd").new();

	for state: BeingState in states.values():
		state.being = self;

	ChangeState("IdleState");


func _process(delta: float) -> void:
	elapsedTime += delta;
	if elapsedTime >= coolDown:
		elapsedTime = 0.0;

		UpdateBeingStats();

		if currentState:
			currentState.Update();

func UpdateBeingStats():
	hunger -= 1;


	if pregnancy != null:
		pregnancy.UpdatePregnancy();
		if pregnancy.IsCompleted():
			GameManager.CreateNewBeing(self);
			pregnancy = null;

func ChangeState(newState: String) -> void:
	if currentState:
		currentState.ExitState();
	currentState = states[newState];

	if currentState:
		currentState.EnterState();

func StartPregnancy():
	pregnancy = Pregnancy.new();

##STATEMACHINE HELPERS
func FindNearestOfResource(resourceType: String) -> GameObject:
	##FIND FOOD SOURCE
	var minPos = clampi(GetPositionNodeIndex() - viewDistance, 0, 19);
	var maxPos = clampi(GetPositionNodeIndex() + viewDistance, 0, 19);

	var objectsOfTypeInView = []

	##GET ALL POSITIONS
	for p in GameManager.positionsNode.get_child_count():
		##IF BEING CAN SEE POISITONS
		if p >= minPos and p <= maxPos:
			##GET ALL OBJECTS ON THAT POSITION
			for obj: GameObject in GameManager.positionsNode.get_children()[p].get_children():
				if obj.type == resourceType:
					objectsOfTypeInView.append(obj);
	
	var minDist = 1000;
	var targetObj = null;

	##CHECK WHICH POSITION WITH FOOD IS NEAREST
	for obj in objectsOfTypeInView:
		if abs(GetPositionNodeIndex() - GetPositionNodeIndex()) < minDist:
			targetObj = obj;
			minDist = abs(GetPositionNodeIndex() - obj.GetPositionNodeIndex());
		
	##IF POS WITH FOOD, MOVE TOWARDS	
	if targetObj != null:
		print("targertobject is " + str(targetObj))

		return targetObj;
	else:
		return null;
