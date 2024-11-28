class_name GameObject extends Node2D;


var type;


func DestroyObject() -> void:
	queue_free();

func GetPositionNodeIndex() -> int:
	for p in GameManager.positionsNode.get_children():
		for c in p.get_children():
			if c == self:
				return p.get_index();
	
	return -1;

func GatherResource() -> String:
	return "Wood";