extends BeingState;

var timeElapsed;
var coolDown = 1.0;

func EnterState() -> void:
	timeElapsed = 0.0;
	#GlobalEvents.emit_signal("beingUpdate", GameEvent.new(being, "beingEnteredIdleState"));
	print(str(being) + " entered idle state");

func ExitState() -> void:
	print(str(being) + " exited idle state");


func Update():
	if being.orderedTask.size() > 0:

		if being.orderedTask[being.orderedTask.size() - 1].taskType == "MoveTo":
			being.ChangeState("MoveState");
		if being.orderedTask[being.orderedTask.size() - 1].taskType == "Consume":
			being.ChangeState("EatState");
		if being.orderedTask[being.orderedTask.size() - 1].taskType == "Gather":
			being.ChangeState("GatherState");
		if being.orderedTask[being.orderedTask.size() - 1].taskType == "Deliver":
			being.ChangeState("DeliverState");
	else:
		NewTaskLogic();
		

func NewTaskLogic():
	var newOrderedTask = [];
	if being.hunger <= 20:
		print(1)
		newOrderedTask.append(ComplexTask.new(being, "Consume"))

		if being.inventory != "Food":
			var nearestFood = being.FindNearestOfResource("Food");

			var newTask: ComplexTask = ComplexTask.new(nearestFood, "Gather");
			newOrderedTask.append(newTask);

			if nearestFood.GetPositionNodeIndex() != being.GetPositionNodeIndex():
				newOrderedTask.append(ComplexTask.new(nearestFood, "MoveTo"));

		being.orderedTask = newOrderedTask;
	
	else:
		##CHECK Population for tasks to be completed
		##Doing wood gathering as example
		newOrderedTask.append(ComplexTask.new(being.population.townSquare, "Deliver"))
		newOrderedTask.append(ComplexTask.new(being.population.townSquare, "MoveTo"));
		
		if !being.inventory != "Wood":
			var nearestTree = being.FindNearestOfResource("Tree");
			newOrderedTask.append(ComplexTask.new(nearestTree, "Gather"));

			if nearestTree.GetPositionNodeIndex() != being.GetPositionNodeIndex():
				newOrderedTask.append(ComplexTask.new(nearestTree, "MoveTo"));

		being.orderedTask = newOrderedTask;
