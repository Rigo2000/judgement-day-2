extends BeingState;

var countDown;

var building: GameObject;

func EnterState() -> void:
	countDown = 10;
	#print(str(being) + " entered the deliver state")
	
func ExitState() -> void:
	pass ;
	#print(str(being) + " exited the deliver state");

func Update() -> void:
	var buildTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Build")];

	if buildTask != null:

		if buildTask.target != null:
			print("sadfs")
			if buildTask.target.health < 100:
				print(buildTask.target.health)
				if buildTask.target.resources.has("Wood"):
					print("23")
					buildTask.target.ChangeHealth(buildTask.target.TakeFromResources(ResourceData.new("Wood", 20)).amount)
					print("building health: " + str(buildTask.target.health));
				else:
					print("#")
					being.population.CreateTask("Deliver", "Wood", buildTask.target);
					being.chainedTask.erase(buildTask);
					being.ChangeState("IdleState");
			else:
				print("building finished")
				being.chainedTask.erase(buildTask);
				being.ChangeState("IdleState");
		else:
			print("building started")
			
			buildTask.target = being.population.BuildHouse(being.GetPositionNodeIndex());
			print(str(buildTask.target.health))
