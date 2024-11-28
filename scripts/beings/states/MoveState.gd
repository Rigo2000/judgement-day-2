extends BeingState


var arrived: bool = false
##A target is a gameobject, like a foodtype or a being
func EnterState():
	arrived = false
	print(being.name, " is moving to: " + str(being.orderedTask[being.orderedTask.size() - 1].target));

func ExitState():
	print(being.name, " stopped moving.")

func Update():
	if being.cTask != null:
		if being.cTask.target.GetPositionNodeIndex() > being.GetPositionNodeIndex():
			MovePosition(1);
		elif being.cTask.target.GetPositionNodeIndex() < being.GetPositionNodeIndex():
			MovePosition(-1);
		elif being.cTask.target.GetPositionNodeIndex() == being.GetPositionNodeIndex():
			arrived = true;

		if arrived:
			being.orderedTask.erase(being.cTask);
			being.ChangeState("IdleState");
			
func MovePosition(amount: int):
	var currentPos = being.GetPositionNodeIndex();
	being.get_parent().remove_child(being);
	GameManager.positionsNode.get_children()[currentPos + amount].add_child(being);
