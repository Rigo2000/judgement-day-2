extends BeingState

var target: GameObject
var next_state: String # The state to transition to after reaching the target
var arrived: bool = false

var moveCooldown = 1.0;
var elapsedTime;

##A target is a gameobject, like a foodtype or a being
func EnterState(_target: GameObject = null, _next_state: String = "null"):
	if _target == null:
		print("WARNING TARGET IS NULL")
	elapsedTime = 0.0;
	target = _target
	next_state = _next_state
	arrived = false
	print(being.name, " is moving to: ", target, " to perform ", next_state)

func ExitState():
	print(being.name, "stopped moving.")

func Update(delta: float):

	elapsedTime += delta;

	##if movecooldown is cooled down
	if elapsedTime >= moveCooldown:
		print(str(target))
		elapsedTime = 0.0;
		#if positionNode index of target is > than positionNode index of being
		if target.GetPositionNodeIndex() > being.GetPositionNodeIndex():
			MovePosition(1);
		elif target.GetPositionNodeIndex() < being.GetPositionNodeIndex():
			MovePosition(-1);
		elif target.GetPositionNodeIndex() == being.GetPositionNodeIndex():
			arrived = true;

	if arrived:
		being.ChangeState(next_state);

func MovePosition(amount: int):
	var currentPos = being.GetPositionNodeIndex();
	being.get_parent().remove_child(being);
	GameManager.positionsNode.get_children()[currentPos + amount].add_child(being);
