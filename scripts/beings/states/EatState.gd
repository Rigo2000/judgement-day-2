extends BeingState;

func EnterState() -> void:
	print(str(being) + " entered the eat state")
	
func ExitState() -> void:
	print(str(being) + " exited the eat state");

func Update() -> void:
	var consumeTask: ComplexTask = being.orderedTask[being.orderedTask.find(func(x): return x.taskType == "Consume")];

	if consumeTask != null:
		if (being.inventory.has(consumeTask.resourceType)):
			being.inventory.erase(consumeTask.resourceType);
			being.hunger += 100;
			print(str(being) + " eats " + consumeTask.resourceType + " and hunger is now " + str(being.hunger));
			being.orderedTask.erase(consumeTask);
			being.ChangeState("IdleState");
		elif !(being.inventory.has(consumeTask.resourceType)):
			print(str(being) + " does not have " + consumeTask.resourceType + " in inventory");
			var newGatherTask = ComplexTask.new().setTaskType("Gather").setResourceType("Food");
			being.orderedTask.append(newGatherTask);
			being.ChangeState("IdleState");