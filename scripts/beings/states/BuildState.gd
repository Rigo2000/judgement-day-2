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
			if buildTask.target.health < 100:
				if buildTask.target.resources.has("Wood"):
					buildTask.target.ChangeHealth(buildTask.target.RequestFromResources(ResourceData.new("Wood", 25)).amount)
					print("building health: " + str(buildTask.target.health));
				else:
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
