extends BeingState;

var count: int = 0;
var actionsPerResource: int = 4;

func EnterState() -> void:
	count = 0;
	print(str(being) + " entered the gather state")
	
func ExitState() -> void:
	print(str(being) + " exited the gather state");

func Update() -> void:
		#if food is still there, eat it
		if being.currentTask.target != null:
			if count < actionsPerResource:
				count += 1;
			elif count >= actionsPerResource:
				count = 0;
				being.inventory.append(being.currentTask.target.GatherResource());
			#GlobalEvents.emit_signal("beingUpdate", GameEvent.new(being, "beingHasEaten"));
				being.currentTask = Task.new("Wood", "Deliver")
				being.ChangeState("IdleState");
		#otherwise go to idlestate
		else:
			being.ChangeState("IdleState");