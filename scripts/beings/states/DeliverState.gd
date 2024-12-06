extends BeingState;

var count: int = 0;
var actionsPerResource: int = 4;

func EnterState() -> void:
	count = 0;
	#print(str(being) + " entered the deliver state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the deliver state");

func Update() -> void:
	var deliverTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Deliver")];

	if deliverTask != null:
		if !(being.resources.has(deliverTask.resourceType)):
			var newGatherTask = Task.new().setTaskType("Gather").setResourceType(deliverTask.resourceType);
			being.chainedTask.append(newGatherTask);
			being.ChangeState("IdleState");
		elif being.resources.has(deliverTask.resourceType):
			##IF being has resource but not at same position as target, Add MoveTo
			if being.GetPositionNodeIndex() != deliverTask.target.GetPositionNodeIndex():
				var newMoveTask = Task.new().setTaskType("MoveTo").setTarget(deliverTask.target);
				being.chainedTask.append(newMoveTask);
				being.ChangeState("IdleState");
			else:
				##HACK FOR TOWNNOW TODO
				deliverTask.target.AddToResources(being.RequestFromResources(ResourceData.new(deliverTask.resourceType, being.resources[deliverTask.resourceType])));
				being.chainedTask.erase(deliverTask);
				being.ChangeState("IdleState");
