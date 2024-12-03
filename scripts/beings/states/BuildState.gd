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

		if building == null:
			##TODO: Should have better logic for building placement
			building = being.population.BuildHouse(being.GetPositionNodeIndex());

		if building.health < 100:
			print("Building Started")
			if building.resources.has("Wood"):
				building.health += building.TakeFromResources(ResourceData.new("Wood", 10)).amount;
			else:
				being.population.CreateTask("Deliver", "Wood", building);
				being.chainedTask.erase(buildTask);
				being.ChangeState("IdleState");
		else:
			being.chainedTask.erase(buildTask);
			being.ChangeState("IdleState");
