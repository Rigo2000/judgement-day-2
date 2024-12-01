class_name Population extends Node2D;

var beings: Array = [];

var buildings: Array = [];
var townSquare: GameObject:
    get:
        for b in buildings:
            if b.type == "townSquare":
                return b;
        return null;

var resources: Dictionary = {"food": 10, "wood": 500}

var taskQueue: Array = [];

# Time management for periodic updates
var elapsedTime: float = 0.0
var coolDown: float = GameManager.stepDuration;


func _process(delta: float) -> void:
    #print(str(taskQueue.size()));
    elapsedTime += delta
    if elapsedTime >= coolDown:
        elapsedTime = 0.0
        AnalyzeNeeds();
    

### Analyze the population's needs and generate tasks
func AnalyzeNeeds() -> void:
    # Check if food is critically low
    if resources.has("food") and resources["food"] < 20:
        CreateTask("Gather", "Food", townSquare);

    # Check if wood is critically low
    if resources.has("wood") and resources["wood"] < 50:
        CreateTask("Gather", "Wood", townSquare);

    # Check for housing needs
    if CountHouses() < beings.size():
            CreateTask("Build", "House");

    # Clean up completed or abandoned tasks
    CleanupTasks()

### Create a population-level task
func CreateTask(taskType: String, resourceType: String, target: GameObject = null) -> void:
    # Avoid duplicate tasks
    for task in taskQueue:
        if task.taskType == taskType and task.resourceType == resourceType and task.status == Task.TaskStatus.AVAILABLE:
            return

    # Create and add a new task to the queue
    var newTask = Task.new().setTaskType(taskType).setResourceType(resourceType).setTarget(target);
    taskQueue.append(newTask)


### Assign a task to a being
func GetTask() -> Task:
    for task in taskQueue:
        if task.status == Task.TaskStatus.AVAILABLE:
            task.status = Task.TaskStatus.ASSIGNED
            return task
    return null

### Mark a task as completed
func CompleteTask(task: Task) -> void:
    if task in taskQueue:
        task.status = Task.TaskStatus.COMPLETED

### Clean up completed or abandoned tasks
func CleanupTasks() -> void:
    for i in range(taskQueue.size() - 1, -1, -1): # Iterate in reverse to safely remove items
        if taskQueue[i].status == Task.TaskStatus.COMPLETED:
            taskQueue.remove_at(i)

### Count the number of houses in the population
func CountHouses() -> int:
    var houseCount = 0
    for building in buildings:
        if building.type == "House":
            houseCount += 1
    return houseCount

############################
func BuildHouse(position: int):
    buildings.append(GameManager.CreateNewGameObject("House", position));