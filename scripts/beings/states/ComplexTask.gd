class_name ComplexTask

var target: GameObject;
var taskType: String;
var resourceType: String;
var noTargetIntPos: int = -1;

# Constructor
func _init() -> void:
    print("New task")

# Fluent setter for target
func setTarget(_target: GameObject) -> ComplexTask:
    target = _target
    return self

# Fluent setter for taskType
func setTaskType(_taskType: String) -> ComplexTask:
    taskType = _taskType
    return self

func setResourceType(_resourceType: String) -> ComplexTask:
    resourceType = _resourceType;
    return self;

# Fluent setter for noTargetIntPos
func setNoTargetIntPos(_intPosTarget: int) -> ComplexTask:
    noTargetIntPos = _intPosTarget
    return self
