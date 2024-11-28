extends BeingState;

func EnterState() -> void:
	print(str(being) + " entered the eat state")
	
func ExitState() -> void:
	print(str(being) + " exited the eat state");

func Update() -> void:
	##EAT FROM INVENTORY
	if being.inventory == "Food":
		being.inventory = "";
		being.hunger += 100;
		print(str(being) + "eats and hunger is now" + str(being.hunger))
		being.orderedTask.erase(being.cTask);
		being.ChangeState("IdleState");
	else:
		print("Error, being has no food in inventory");