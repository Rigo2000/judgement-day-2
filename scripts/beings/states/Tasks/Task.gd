class_name Task

enum TaskStatus {AVAILABLE, ASSIGNED, COMPLETED, FAILED}

var target: GameObject
var taskType: String
var resourceType: String
var amount: int;
var noTargetIntPos: int = -1
var initiatorTask: Task;
var status: TaskStatus = TaskStatus.AVAILABLE

var attempts;

# Fluent setters
func setTarget(_target: GameObject) -> Task:
    target = _target
    return self

func setTaskType(_taskType: String) -> Task:
    taskType = _taskType
    return self

func setResourceType(_resourceType: String) -> Task:
    resourceType = _resourceType
    return self

func setNoTargetIntPos(_intPosTarget: int) -> Task:
    noTargetIntPos = _intPosTarget
    return self

func setAmount(_amount: int) -> Task:
    amount = _amount;
    return self;

func setInitiatorTask(_task: Task) -> Task:
    initiatorTask = _task;
    return self;

func GetTaskString() -> String:
    var newString = "";

    if taskType != null:
        newString += str(taskType) + " ";
    
    if resourceType != null:
        newString += str(resourceType) + " ";
    
    if target != null:
        newString += str(target) + " ";
    
    if noTargetIntPos != -1:
        newString += str(noTargetIntPos);

    return newString;
