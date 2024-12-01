extends BeingState;

func EnterState() -> void:
	pass ;
	#print(str(being) + " entered mate state ")
	

func ExitState() -> void:
	pass ;
	#print(str(being) + " exited mate state ")

func Update() -> void:
	var mateTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Mate")];
	
	if mateTask.target.GetPositionNodeIndex() != being.GetPositionNodeIndex():
		var newMoveTask = Task.new().setTaskType("MoveTo").setTarget(mateTask.target);
		being.chainedTask.append(newMoveTask);
		being.ChangeState("IdleState");
	else:
		being.StartPregnancy();
		being.chainedTask.erase(mateTask);
		being.ChangeState("IdleState");