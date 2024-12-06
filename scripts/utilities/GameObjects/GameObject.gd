class_name GameObject extends Node2D;

@export var label: Label;

var type;

var health: int;

var resources = {}

func ChangeHealth(amount: int):
	health = clamp(health + amount, 0, 100);
	
func _ready() -> void:
	label.text = type;
	health = 100;

func GetPositionNodeIndex() -> int:
	for p in GameManager.positionsNode.get_children():
		for c in p.get_children():
			if c == self:
				return p.get_index();
	
	return -1;

func AddToResources(resourceData: ResourceData):
	if resources.has(resourceData.type):
		resources[resourceData.type] += resourceData.amount;
	else:
		resources[resourceData.type] = resourceData.amount;

func RequestFromResources(resourceData: ResourceData) -> ResourceData:
	if resources.has(resourceData.type):
		if resources[resourceData.type] - resourceData.amount > 0:
			resources[resourceData.type] -= resourceData.amount;
			return ResourceData.new(resourceData.type, resourceData.amount);
		else:
			var num = resources[resourceData.type];
			resources.erase(resourceData.type);
			return ResourceData.new(resourceData.type, num);
	else:
		print(str(self) + " doesnt contain any " + resourceData.type)
		return ResourceData.new("null", 0);

func IsResourcesEmpty() -> bool:
	return resources.is_empty();

func DestroyObject():
	queue_free();
