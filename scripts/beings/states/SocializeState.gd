extends BeingState;

func EnterState() -> void:
	pass ;
	#print(str(being) + " entered socialize state ")
	

func ExitState() -> void:
	pass ;
	#print(str(being) + " exited socialize state ")

func Update() -> void:
	var socializeTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Socialize")];
	
	if !socializeTask.target.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Socialize")]:
		##If current target is no longer socializing, find new target
		socializeTask.target == null;
		being.ChangeState("IdleState");

	if socializeTask.target == null:
		##Find resource should be better, and take in more parameters
		##maybe be a class in and of itself TODO
		##Maybe "find" is a task itself
		var newSearchTask = Task.new().setInitiatorTask(socializeTask).setTaskType("Search");
		being.chainedTask.append(newSearchTask);
		being.ChangeState("IdleState");
	
	if socializeTask.target.GetPositionNodeIndex() != being.GetPositionNodeIndex():
		var newMoveTask = Task.new().setTaskType("MoveTo").setTarget(socializeTask.target);
		being.chainedTask.append(newMoveTask);
		being.ChangeState("IdleState");

	if being.personality.get_emotion("happiness") < 100:
		var friendliness_factor = being.personality.get_trait("friendliness") / 100.0

	# Adjust emotions based on friendliness
		being.personality.adjust_emotion("happiness", 5 + friendliness_factor * 5) # Base increase + friendliness boost
		being.personality.adjust_emotion("stress", -(3 + friendliness_factor * 2)) # Reduce stress more with friendliness
		being.personality.adjust_emotion("fear", -(2 + friendliness_factor * 2)) # Fear reduction scales with friendliness
		being.personality.adjust_emotion("anger", -(1 + friendliness_factor * 3)) # Anger heavily affected by friendliness

	else:
		being.chainedTask.erase(socializeTask); # Task complete
		being.ChangeState("IdleState");
