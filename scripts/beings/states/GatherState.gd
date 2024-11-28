extends BeingState;

var count: int = 0;
var actionsPerResource: int = 1;

func EnterState() -> void:
	count = 0;
	print(str(being) + " entered the gather state")
	
func ExitState() -> void:
	print(str(being) + " exited the gather state");

func Update() -> void:
	if being.cTask.target != null:
		count += 1;
		if count >= actionsPerResource:
			count = 0;
			being.inventory = being.cTask.target.GatherResource();
			being.orderedTask.erase(being.cTask);
			being.ChangeState("IdleState");