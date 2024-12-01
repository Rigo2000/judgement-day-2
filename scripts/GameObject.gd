class_name GameObject extends Node2D;

@export var label: Label;

var type;

var inventory = [];

var resources = {}

func _ready() -> void:
	label.text = type;

func DestroyObject() -> void:
	queue_free();

func GetPositionNodeIndex() -> int:
	for p in GameManager.positionsNode.get_children():
		for c in p.get_children():
			if c == self:
				return p.get_index();
	
	return -1;

func GatherResource() -> String:
	DestroyObject();
	return type;