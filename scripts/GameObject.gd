class_name GameObject extends Node2D;

@export var label: Label;

var type;

var resources = {}

func _ready() -> void:
	label.text = type;

func DestroyObject() -> void:
	var isEmpty:bool = true;

	for r in resources.values():
		if r > 0:
			isEmpty = false;

	if isEmpty:
		queue_free();

func GetPositionNodeIndex() -> int:
	for p in GameManager.positionsNode.get_children():
		for c in p.get_children():
			if c == self:
				return p.get_index();
	
	return -1;

func GatherResource(_type: String) -> String:
	DestroyObject();
	return type;

func AddToResources(_type: String, _amount: int):
	if resources.has(_type):
		resources[_type] += _amount;
	else:
		resources[_type] = _amount;