class_name Task

enum TaskStatus {AVAILABLE, ASSIGNED, COMPLETED, FAILED}

var target: GameObject
var taskType: String
var resourceType: String
var noTargetIntPos: int = -1
var status: TaskStatus = TaskStatus.AVAILABLE

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
