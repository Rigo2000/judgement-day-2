class_name GameObject extends Node2D;

@export var label: Label;

var type;

var resources = {}

func _ready() -> void:
	
	label.text = type;

func DestroyObjectCheck() -> void:
	
	var isEmpty: bool = true;

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

func TakeFromResources(_rData: ResourceData) -> ResourceData:
	if resources.has(_rData.type):
		if resources[_rData.type] - _rData.amount > 0:
			return ResourceData.new(_rData.type, _rData.amount);
		else:
			DestroyObjectCheck();
			return ResourceData.new(_rData.type, resources[_rData.type]);
	else:
		return ResourceData.new("", 0);


func AddToResources(_rData: ResourceData):
	if resources.has(_rData.type):
		resources[_rData.type] += _rData.amount;
	else:
		resources[_rData.type] = _rData.amount;