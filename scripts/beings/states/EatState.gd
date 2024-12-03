extends BeingState;

func EnterState() -> void:
	pass ;
	#print(str(being) + " entered the eat state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the eat state");

func Update() -> void:
	var consumeTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Consume")];

	if consumeTask != null:
		if (being.resources.has(consumeTask.resourceType)):
			being.ConsumeResource(ResourceData.new(consumeTask.resourceType, 10));
			being.hunger += 100;
			#print(str(being) + " eats " + consumeTask.resourceType + " and hunger is now " + str(being.hunger));
			being.chainedTask.erase(consumeTask);
			being.ChangeState("IdleState");
		elif !(being.resources.has(consumeTask.resourceType)):
			var newGatherTask = Task.new().setTaskType("Gather").setResourceType(consumeTask.resourceType);
			being.chainedTask.append(newGatherTask);
			being.ChangeState("IdleState");