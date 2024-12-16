extends BeingState;

func EnterState() -> void:
	pass ;
	#print(str(being) + " entered the eat state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the eat state");

func Update() -> void:
	var sleepTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Sleep")];

	if sleepTask != null:
		##Find house
		if sleepTask.target == null:
			being.chainedTask.append(Task.new().setTaskType("Search").setInitiatorTask(sleepTask));
			being.ChangeState("IdleState");
			return ;

		else:
			if being.GetPositionNodeIndex() != sleepTask.target.GetPositionNodeIndex():
				being.chainedTask.append(Task.new().setTaskType("MoveTo").setTarget(sleepTask.target));
				being.ChangeState("IdleState");
				return ;
			else:
				if being.sleep < 100:
					being.sleep += 10;
					return ;
				else:
					being.chainedTask.erase(sleepTask);
					being.ChangeState("IdleState");
					return ;
	else:
		being.ChangeState("IdleState");
		return ;
