class_name Being extends GameObject;

var hunger: int;
var health: int;
var age: int;
var sleep: int;
var devotion: int;

var pop: Population;

var currentState = null;
var states = {};

var reach: int = 0;
var viewDistance: int = 5;

var pos: int:
	get:
		return GetPositionNodeIndex();

func _ready() -> void:
	states["IdleState"] = preload("res://scripts/beings/states/IdleState.gd").new();
	states["EatState"] = preload("res://scripts/beings/states/EatState.gd").new();
	states["MoveState"] = preload("res://scripts/beings/states/MoveState.gd").new();

	for state: BeingState in states.values():
		state.being = self;

	ChangeState("IdleState");


func _process(delta: float) -> void:
	if currentState:
		currentState.Update(delta);

func ChangeState(newState: String, target: GameObject = null, nextState: String = "null") -> void:
	if currentState:
		currentState.ExitState();
	currentState = states[newState];

	if currentState:
		if target == null && nextState == "null":
			currentState.EnterState();
		elif target != null && nextState != null:
			currentState.EnterState(target, nextState);


func MakePrayer() -> void:
	var conditions: Array[Condition] = [];

	conditions.append(Condition.new(self, "hunger", 100));

	GameManager.qm.CreateNewQuest(self, conditions);
