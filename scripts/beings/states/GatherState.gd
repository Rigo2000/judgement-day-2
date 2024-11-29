extends BeingState;

var count: int = 0;
var actionsPerResource: int = 5;

func EnterState() -> void:
	count = 0;
	print(str(being) + " entered the gather state")
	
func ExitState() -> void:
	print(str(being) + " exited the gather state");

func Update() -> void:
	var gatherTask = being.orderedTask[being.orderedTask.find(func(x): return x.taskType == "Gather")];

	if gatherTask != null:
		var nearestResourceOfType = being.FindNearestOfResource(gatherTask.resourceType);

		if nearestResourceOfType == null:
			var newWanderTask = ComplexTask.new().setTaskType("MoveTo").setTarget(clamp(being.GetPositionNodeIndex() + randi_range(-being.viewDistance, being.viewDistance), 0, 19));
			being.orderedTask.append(newWanderTask);
			being.ChangeState("IdleState");

		##If not on same position, add move task
		if nearestResourceOfType.GetPositionNodeIndex() != being.GetPositionNodeIndex():
			var newMoveTask = ComplexTask.new().setTaskType("MoveTo").setTarget(nearestResourceOfType);
			being.orderedTask.append(newMoveTask);
			being.ChangeState("IdleState");
		##Else gather it
		else:
			being.inventory.append(nearestResourceOfType.GatherResource())
			being.orderedTask.erase(gatherTask);
			being.ChangeState("IdleState");