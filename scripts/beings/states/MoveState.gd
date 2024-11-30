extends BeingState


var arrived: bool = false
##A target is a gameobject, like a foodtype or a being
func EnterState():
	print(str(being) + " entered the move state")
	arrived = false
	print(being.name, " is moving to: " + str(being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "MoveTo")].target));

func ExitState():
	print(str(being) + " exited the move state")

func Update():
	var moveTask = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "MoveTo")];

	if moveTask != null:
		var targetPos;

		if moveTask.target != null:
			targetPos = moveTask.target.GetPositionNodeIndex();
		elif moveTask.target == null && moveTask.noTargetIntPos != 1:
			targetPos = moveTask.noTargetIntPos;

		if targetPos > being.GetPositionNodeIndex():
			MovePosition(1);
		elif targetPos < being.GetPositionNodeIndex():
			MovePosition(-1);
		elif targetPos == being.GetPositionNodeIndex():
			arrived = true;

		if arrived:
			being.chainedTask.erase(moveTask);
			being.ChangeState("IdleState");

func MovePosition(amount: int):
	var currentPos = being.GetPositionNodeIndex();
	being.get_parent().remove_child(being);
	GameManager.positionsNode.get_children()[currentPos + amount].add_child(being);
