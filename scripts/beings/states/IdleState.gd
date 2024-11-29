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
	being.orderedTask.clear();
	if being.hunger <= 80:
		being.orderedTask.append(ComplexTask.new().setTaskType("Consume").setResourceType("Food"));


func BeingWanderTask():
	being.orderedTask.clear();
	##Get a random position near being
	var randomPos: int = clamp(being.GetPositionNodeIndex() + randi_range(-being.viewDistance, being.viewDistance), 0, 19);
	##TODO: Fix the wander task
	being.orderedTask.append(ComplexTask.new());
