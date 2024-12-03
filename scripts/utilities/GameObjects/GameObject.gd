class_name GameObject extends Node2D;

@export var label: Label;

var type;

var health: int;

var resources = {}

func ChangeHealth(amount: int):
	health = clamp(health + amount, 0, 100);
	

func _process(delta: float) -> void:
	DestroyObjectCheck();

func _ready() -> void:
	label.text = type;
	health = 100;

func DestroyObjectCheck() -> void:
	
	if health <= 0:
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
			var newR = ResourceData.new(_rData.type, resources[_rData.type]);
			resources.erase(_rData.type);
			return newR;
	else:
		print("Error: being does not have resources, shouldnt have ended here")
		return null;


func AddToResources(_rData: ResourceData):
	if resources.has(_rData.type):
		resources[_rData.type] += _rData.amount;
	else:
		resources[_rData.type] = _rData.amount;
