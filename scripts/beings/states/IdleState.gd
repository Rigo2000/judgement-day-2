extends BeingState;

func EnterState() -> void:
	pass ;
	#print(str(being) + " entered idle state");

func ExitState() -> void:
	pass ;
	#print(str(being) + " exited idle state");

func Update():
	# Check if there are any chained tasks
	if being.chainedTask.size() > 0:
		var current_task = being.chainedTask[being.chainedTask.size() - 1]
		if current_task != null:
			match current_task.taskType:
				"MoveTo":
					being.ChangeState("MoveState")
				"Consume":
					being.ChangeState("EatState")
				"Gather":
					being.ChangeState("GatherState")
				"Deliver":
					being.ChangeState("DeliverState")
				"Mate":
					being.ChangeState("MateState")
				"Sleep":
					being.ChangeState("SleepState")
				"Build":
					being.ChangeState("BuildState")
				"Socialize":
					being.ChangeState("SocializeState")
	else:
		# No tasks? Determine new tasks based on personality, emotions, and needs
		NewTaskLogic()

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
			if being.ageInDays > 13 && being.pregnancy == null:
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
	while randomBeingInPopulation == being || randomBeingInPopulation.pregnancy != null || randomBeingInPopulation.ageInDays < 13:
		tries += 1;
		if tries > 50:
			break ;
		randomBeingInPopulation = being.population.beings[randi_range(0, being.population.beings.size() - 1)];
	
	if randomBeingInPopulation != being:
		return Task.new().setTaskType("Mate").setTarget(randomBeingInPopulation);
	else:
		return null;
