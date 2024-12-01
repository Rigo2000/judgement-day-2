extends BeingState;

var timeElapsed;
var coolDown = 1.0;

func EnterState() -> void:
	timeElapsed = 0.0;
	#print(str(being) + " entered idle state");

func ExitState() -> void:
	pass ;
	#print(str(being) + " exited idle state");

func Update():
	if being.chainedTask.size() > 0:
		if (being.chainedTask[being.chainedTask.size() - 1] != null):
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "MoveTo":
				being.ChangeState("MoveState");
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "Consume":
				being.ChangeState("EatState");
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "Gather":
				being.ChangeState("GatherState");
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "Deliver":
				being.ChangeState("DeliverState");
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "Mate":
				being.ChangeState("MateState");
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "Sleep":
				being.ChangeState("SleepState");
			if being.chainedTask[being.chainedTask.size() - 1].taskType == "Build":
				being.ChangeState("BuildState");
	else:
		NewTaskLogic();
		

func NewTaskLogic():
	being.chainedTask.clear();
	if being.hunger <= 10:
		being.chainedTask.append(Task.new().setTaskType("Consume").setResourceType("Food"));
	
	elif being.sleep <= 10:
		being.chainedTask.append(Task.new().setTaskType("Sleep"));

	else:
		var populationTask = being.population.GetTask();

		if populationTask != null:
			being.chainedTask.append(populationTask);
		else:
			##Do idle tasks like pray, wander, mate
			##Based somewhat on personality
			var mateTask = GetMateTask();
			if mateTask != null:
				being.chainedTask.append(mateTask);
			else:
				being.chainedTask.append(GetWanderTask());
			

func GetWanderTask() -> Task:
	being.chainedTask.clear();
	##Get a random position near being
	var randomPos: int = clamp(being.GetPositionNodeIndex() + randi_range(-being.viewDistance, being.viewDistance), 0, 99);
	##TODO: Fix the wander task
	return Task.new().setTaskType("MoveTo").setNoTargetIntPos(randomPos);

func GetMateTask() -> Task:
	#print(being.population.beings.size())

	being.chainedTask.clear();

	var randomBeingInPopulation = being.population.beings[randi_range(0, being.population.beings.size() - 1)];
	var tries = 0;
	while randomBeingInPopulation == being && randomBeingInPopulation.pregnancy != null:
		tries += 1;
		if tries > 50:
			break ;
		randomBeingInPopulation = being.population.beings[randi_range(0, being.population.beings.size() - 1)];
	
	if randomBeingInPopulation != being:
		return Task.new().setTaskType("Mate").setTarget(randomBeingInPopulation);
	else:
		return null;
