extends BeingState;

func EnterState() -> void:
	print(str(being) + " entered the eat state")
	
func ExitState() -> void:
	print(str(being) + " exited the eat state");

func Update() -> void:
		#if food is still there, eat it
		if being.currentTask.target != null && being.currentTask.target.type == "Food":
			being.currentTask.target.DestroyObject();
			#GlobalEvents.emit_signal("beingUpdate", GameEvent.new(being, "beingHasEaten"));
			being.hunger += 50;
			print(str(being) + "eats and hunger is now" + str(being.hunger))
			being.currentTask = null;
			being.ChangeState("IdleState");
		#otherwise go to idlestate
		else:
			being.ChangeState("IdleState");