extends BeingState;

var timeElapsed;
var coolDown = 1.0;

func EnterState() -> void:
	timeElapsed = 0.0;
	#GlobalEvents.emit_signal("beingUpdate", GameEvent.new(being, "beingEnteredIdleState"));
	print(str(being) + " entered idle state");

	if being.currentTask == null:
		FindNewTask();

func ExitState() -> void:
	print(str(being) + " exited idle state");


func Update():
	##HACK TODO
	if true:
		if being.currentTask != null:
			##Does the being has a target for the task yet?
			if being.currentTask.target == null:
				if being.currentTask.primaryTask == "Gather":
					var nearestObjectOfType = being.FindNearestOfResource(being.currentTask.resourceType);
					being.currentTask.target = nearestObjectOfType;
				elif being.currentTask.primaryTask == "Deliver":
					##ASK POPULATION FOR LOCATION OF PLACE THAT NEEDS IT
					##OR IF NO NEED IT; DELIVER IT TO TOWN STOCK
					pass ;

			##Is the being currently on the targetpos
			if being.currentTask.target.GetPositionNodeIndex() != being.GetPositionNodeIndex():
				being.currentTask.secondaryTask = "MoveTo";
				being.ChangeState("MoveState");

			if being.currentTask.secondaryTask == "null":
				if being.currentTask.primaryTask == "Gather":
					being.ChangeState("GatherState");
				if being.currentTask.primaryTask == "Consume":
					being.ChangeState("EatState");
		else:
			FindNewTask();


func FindNewTask():
	if being.hunger <= 40:
		var newTask: Task = Task.new("Food", "Consume");
		print(str(being) + " hunger is " + str(being.hunger) + " getting new task " + str(newTask))
		being.currentTask = newTask;


func NewUpdate


var orderedTask = [];

func NewTaskLogic():
	var newOrderedTask = [];
	if being.hunger <= 20:
		var nearestFood = being.FindNearestOfResource("Food");

		var newTask: ComplexTask = ComplexTask.new(nearestFood, "Consume");
		newOrderedTask.append(newTask);

		if nearestFood.GetPositionNodeIndex() != being.GetPositionNodeIndex():
			newOrderedTask.append(ComplexTask.new(nearestFood, "MoveTo"));

		orderedTask = newOrderedTask;
	
	else:
		##CHECK Population for tasks to be completed
		##Doing wood gathering as example
		newOrderedTask.append(ComplexTask.new(being.population.townSquare, "DeliverWood"))
		
		if !being.inventory.has("Wood"):
			var nearestTree = being.FindNearestOfResource("Tree");
			newOrderedTask.append(ComplexTask.new(nearestTree, "Gather"));

			if nearestTree.GetPositionNodeIndex() != being.GetPositionNodeIndex():
				newOrderedTask.append(ComplexTask.new(nearestTree, "MoveTo"));

		orderedTask = newOrderedTask;
