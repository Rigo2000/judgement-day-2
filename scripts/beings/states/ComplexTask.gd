class_name ComplexTask;

var target: GameObject;
var taskType: String;

func _init(_target: GameObject, _taskType: String) -> void:
    target = _target;
    taskType = _taskType;