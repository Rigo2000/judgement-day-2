class_name Building;

extends GameObject;
enum BuildingStatus {
    UNDER_CONSTRUCTION,
    CONSTRUCTION_FINISHED
}

var status: BuildingStatus = BuildingStatus.UNDER_CONSTRUCTION;

var buildingType;

func _ready() -> void:
    super();
    health = 1;

func Build():
    if health < 100:
        health += 10;
    else:
        status = BuildingStatus.CONSTRUCTION_FINISHED;
