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
				"Search":
					being.ChangeState("SearchState");
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
	being.chainedTask.clear()

	# Step 1: Address immediate needs
	if being.hunger <= 10:
		being.chainedTask.append(Task.new().setTaskType("Consume").setResourceType("Food"))
		return
	elif being.sleep <= 10:
		being.chainedTask.append(Task.new().setTaskType("Sleep"))
		return

	# Step 2: Evaluate population tasks
	var population_task = being.population.GetTask()
	if population_task != null:
		being.chainedTask.append(population_task)
		return


	# Step 3: Personality-driven task selection
	var task_priority = CalculateTaskPriority()

	# Determine the highest-priority task
	var selected_task_type = null
	for task in task_priority.keys():
		if selected_task_type == null or task_priority[task] > task_priority[selected_task_type]:
			selected_task_type = task

	# Step 4: Assign the selected task
	match selected_task_type:
		"Socialize":
			being.chainedTask.append(Task.new().setTaskType("Socialize"));
		"Explore":
			being.chainedTask.append(GetWanderTask())
		"Build":
			var build_task = being.population.GetTask()
			if build_task != null:
				being.chainedTask.append(build_task)
		"Pray":
			being.chainedTask.append(Task.new().setTaskType("Pray"))

	# Fallback task
	if being.chainedTask.size() == 0:
		being.chainedTask.append(GetWanderTask())

func CalculateTaskPriority() -> Dictionary:
	# Adjust task priorities using personality traits and emotions
	return {
		"Socialize": being.personality.get_trait("friendliness") + (being.personality.get_emotion("happiness") * 0.5),
		"Explore": being.personality.get_trait("curiosity"),
		"Hunt": being.personality.get_trait("aggression") - (being.personality.get_emotion("happiness") * 0.3),
		"Build": being.personality.get_trait("industriousness"),
		"Pray": being.personality.get_trait("spirituality") - (being.personality.get_emotion("stress") * 0.2),
	}

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
