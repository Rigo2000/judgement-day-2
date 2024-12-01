extends BeingState;

var sleepDuration = 10;

func EnterState() -> void:
	sleepDuration = 10;
	pass ;
	#print(str(being) + " entered the eat state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the eat state");

func Update() -> void:
	sleepDuration -= 1;

	var sleepTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Sleep")];

	if sleepTask != null:
		if sleepDuration <= 0:
			being.sleep = 100;
			being.chainedTask.erase(sleepTask);
			being.ChangeState("IdleState");

	else:
		being.ChangeState("IdleState");
