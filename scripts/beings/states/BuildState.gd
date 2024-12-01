extends BeingState;

var countDown;

func EnterState() -> void:
	countDown = 10;
	#print(str(being) + " entered the deliver state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the deliver state");

func Update() -> void:
	countDown -= 1;

	var buildTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Build")];

	if buildTask != null:
		if countDown <= 0:
			being.population.BuildHouse(being.GetPositionNodeIndex());
			being.chainedTask.erase(buildTask);
			being.ChangeState("IdleState");
