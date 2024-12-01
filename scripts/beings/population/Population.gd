class_name Population extends Node2D;

var beings: Array = [];

var buildings: Array = [];
var townSquare: GameObject;

var taskQueue: Array = [];

# Time management for periodic updates
var elapsedTime: float = 0.0
var coolDown: float = GameManager.stepDuration;

func _ready() -> void:
    BuildTownSquare(50);

    townSquare.resources = {"food": 0, "wood": 500}

func _process(delta: float) -> void:
    #print(str(taskQueue.size()));
    elapsedTime += delta
    if elapsedTime >= coolDown:
        elapsedTime = 0.0
        AnalyzeNeeds();
    

### Analyze the population's needs and generate tasks
func AnalyzeNeeds() -> void:
    # Check if food is critically low
    if townSquare.resources.has("food") and townSquare.resources["food"] < 20:
        CreateTask("Deliver", "Food", townSquare);

    # Check if wood is critically low
    if townSquare.resources.has("wood") and townSquare.resources["wood"] < 50:
        CreateTask("Deliver", "Wood", townSquare);

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
func BuildHouse(_position: int):
    buildings.append(GameManager.CreateNewGameObject("House", _position));

func BuildTownSquare(_position: int):
    townSquare = GameManager.CreateNewGameObject("TownSquare", _position)
    buildings.append(townSquare);
    print(townSquare.type);