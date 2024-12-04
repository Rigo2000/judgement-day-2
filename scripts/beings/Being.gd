class_name Being extends GameObject;

var hunger: int;
var age: int;
var sleep: int;
var devotion: int;

var data: BeingData;

var pregnancy;

var population: Population;

var currentState: BeingState = null;
var states = {};

var reach: int = 0;
var viewDistance: int = 20;

var birthday: int;

var ageInDays: int:
	get:
		return GameManager.day - birthday;

var pos: int:
	get:
		return GetPositionNodeIndex();

var chainedTask = [];
		
var coolDown: float = GameManager.stepDuration;
var elapsedTime;

func _ready() -> void:
	print(str(typeof(self)));
	hunger = 20;
	elapsedTime = 0.0;
	states["IdleState"] = preload("res://scripts/beings/states/IdleState.gd").new();
	states["EatState"] = preload("res://scripts/beings/states/EatState.gd").new();
	states["MoveState"] = preload("res://scripts/beings/states/MoveState.gd").new();
	states["GatherState"] = preload("res://scripts/beings/states/GatherState.gd").new();
	states["DeliverState"] = preload("res://scripts/beings/states/DeliverState.gd").new();
	states["MateState"] = preload("res://scripts/beings/states/MateState.gd").new();
	states["SleepState"] = preload("res://scripts/beings/states/SleepState.gd").new();
	states["BuildState"] = preload("res://scripts/beings/states/BuildState.gd").new();

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
	sleep -= 1;
	if pregnancy != null:
		pregnancy.UpdatePregnancy();
		if pregnancy.IsCompleted():
			GameManager.CreateNewBeing(self);
			pregnancy = null;

func UpdateBeingLabel() -> String:
	var newString = "";
	newString += "Age: " + str(ageInDays);
	newString += "\n Hunger:" + str(hunger)
	newString += "\n Sleep:" + str(sleep);


	for t: Task in chainedTask:
		newString += "\n" + t.GetTaskString();

	return newString;

func ChangeState(newState: String) -> void:
	if currentState:
		currentState.ExitState();
	currentState = states[newState];

	if currentState:
		currentState.EnterState();

func ConsumeResource(_rData: ResourceData):
	if resources.has(_rData.type):
		if resources[_rData.type] > _rData.amount:
			resources[_rData.type] -= _rData.amount;
		else:
			resources[_rData.type] = 0;

func StartPregnancy():
	print(str(self) + " is preggos");
	pregnancy = Pregnancy.new();

##STATEMACHINE HELPERS
func FindNearestOfResource(resourceType: String) -> GameObject:
	##FIND FOOD SOURCE
	var minPos = clampi(GetPositionNodeIndex() - viewDistance, 0, 99);
	var maxPos = clampi(GetPositionNodeIndex() + viewDistance, 0, 99);

	var objectsOfTypeInView = []

	##GET ALL POSITIONS
	for p in GameManager.positionsNode.get_child_count():
		##IF BEING CAN SEE POISITONS
		if p >= minPos and p <= maxPos:
			##GET ALL OBJECTS ON THAT POSITION
			for obj: GameObject in GameManager.positionsNode.get_children()[p].get_children():
				if obj.resources.has(resourceType):
					objectsOfTypeInView.append(obj);
	
	var minDist = 1000;
	var targetObj = null;

	#Check if any of the holders of the resource is another being
	objectsOfTypeInView = objectsOfTypeInView.filter(func(x): return x.type != "Being");

	#check if there's a deliver task in the stack
	var checkForDeliverTask = chainedTask.filter(func(x): return x.taskType == "Deliver");

	#Remove the target of the delivertask from the stack if it is in there
	if checkForDeliverTask.size() > 0:
		objectsOfTypeInView = objectsOfTypeInView.filter(func(x): return x != checkForDeliverTask[0].target);

	##CHECK WHICH POSITION WITH FOOD IS NEAREST
	for obj in objectsOfTypeInView:
		if abs(GetPositionNodeIndex() - obj.GetPositionNodeIndex()) < minDist:
			targetObj = obj;
			minDist = abs(GetPositionNodeIndex() - obj.GetPositionNodeIndex());
		
	##IF POS WITH FOOD, MOVE TOWARDS	
	if targetObj != null:
		#print("targertobject is " + str(targetObj))

		return targetObj;
	else:
		return null;

func SelectBeing():
	GameManager.selectedBeing = self;


func _on_button_pressed() -> void:
	SelectBeing();
