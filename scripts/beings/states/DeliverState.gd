extends BeingState;

var count: int = 0;
var actionsPerResource: int = 4;

func EnterState() -> void:
	count = 0;
	print(str(being) + " entered the deliver state")
	
func ExitState() -> void:
	print(str(being) + " exited the deliver state");

func Update() -> void:
		#if food is still there, eat it
		if being.currentTask.target != null:
            ##LOGIC FOR GIVING RESOUCE TO PLACE

            ##LOGIC FOR REMOVING FROM INVENTORY
			being.inventory.erase(being.currentTask.resourceType);
			being.currentTask = null;
			being.ChangeState("IdleState");
		#otherwise go to idlestate
		else:
			being.ChangeState("IdleState");