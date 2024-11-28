class_name Population;

var beings: Dictionary;
var resources: Dictionary = {
    "food": 0,
    "wood": 0,
    "stone": 0,
}
var buildings: Dictionary;
var townSquare: GameObject;

var workforce: Dictionary = {
    "farmers": 0, "builders": 0, "woodcutter": 0, "stonecutter": 0
}

func GetHousingCapacity() -> int:
    var cap = 0;
    for building in buildings:
        if building.housing != null:
            cap += building.housing;
    
    return cap;

func GetFoodAmount() -> int:
    return resources.food;

func GetWoodAmount() -> int:
    return resources.wood;

func GetCurrentPopulation() -> int:
    return beings.size();

func IsFoodSufficient() -> bool:
    var food_needed = GetCurrentPopulation() * 2 # 2 food per being per cycle
    var food_in_progress = (workforce["farmers"]);
    
    return (resources["food"] + food_in_progress) >= food_needed;

func IsWoodSufficient() -> bool:
    if resources["wood"] < 20:
        return false;
    else:
        return true;

func DetermineTask() -> String:
    if !IsFoodSufficient():
        return "farm";
    elif !IsWoodSufficient():
        return "gatherWood";
    else:
        return "idle";