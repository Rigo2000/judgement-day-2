extends BeingState;

var count: int = 0;
var actionsPerResource: int = 5;

func EnterState() -> void:
	count = 0;
	#print(str(being) + " entered the gather state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the gather state");

func Update() -> void:
	var gatherTask = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Gather")];

	if gatherTask != null:
		if gatherTask.target == null:
			var nearestResourceOfType = being.FindNearestOfResource(gatherTask.resourceType);
			#print(gatherTask.resourceType)
			if nearestResourceOfType == null:
				#print(1)
				var newWanderTask = Task.new().setTaskType("MoveTo").setNoTargetIntPos(clamp(being.GetPositionNodeIndex() + randi_range(-being.viewDistance, being.viewDistance), 0, 99));
				being.chainedTask.append(newWanderTask);
				being.ChangeState("IdleState");
			else:
				#print(2)
				gatherTask.target = nearestResourceOfType;
				being.ChangeState("IdleState");

		else:
			##If not on same position, add move task
			if gatherTask.target.GetPositionNodeIndex() != being.GetPositionNodeIndex():
				var newMoveTask = Task.new().setTaskType("MoveTo").setTarget(gatherTask.target);
				being.chainedTask.append(newMoveTask);
				being.ChangeState("IdleState");
			##Else gather it
			else:
				being.AddToResources(gatherTask.target.Remove
				gatherTask.status = Task.TaskStatus.COMPLETED;
				being.chainedTask.erase(gatherTask);
				being.ChangeState("IdleState");
