extends BeingState


var arrived: bool = false

var moveCooldown = 1.0;
var elapsedTime;

##A target is a gameobject, like a foodtype or a being
func EnterState():
	if being.currentTask.target == null:
		print("WARNING TARGET IS NULL")
	elapsedTime = 0.0;
	arrived = false
	print(being.name, " is moving to: ", being.currentTask.target)

func ExitState():
	print(being.name, " stopped moving.")

func Update():
	##if movecooldown is cooled down (HACK)	
	if true:
		if being.currentTask.target != null:
			#if positionNode index of target is > than positionNode index of being
			if being.currentTask.target.GetPositionNodeIndex() > being.GetPositionNodeIndex():
				MovePosition(1);
			elif being.currentTask.target.GetPositionNodeIndex() < being.GetPositionNodeIndex():
				MovePosition(-1);
			elif being.currentTask.target.GetPositionNodeIndex() == being.GetPositionNodeIndex():
				arrived = true;

			if arrived:
				being.currentTask.secondaryTask = "null";
				being.ChangeState("IdleState");
		else:
			being.ChangeState("IdleState");

func MovePosition(amount: int):
	var currentPos = being.GetPositionNodeIndex();
	being.get_parent().remove_child(being);
	GameManager.positionsNode.get_children()[currentPos + amount].add_child(being);
