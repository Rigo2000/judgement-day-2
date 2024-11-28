class_name Task;

var resourceType: String;
var primaryTask: String;
var secondaryTask: String;
var target: GameObject;

func _init(_resourceType: String, _primaryTask: String) -> void:
    primaryTask = _primaryTask;
    resourceType = _resourceType;