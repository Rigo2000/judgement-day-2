class_name Quest;

extends Node2D;

var id: String;
var title: String;
var conditions: Array[Condition];
var reward: int;
var status: Status = Status.available;
var being: Being;
var target: Being;

enum Status {
    available,
    active,
    completed
}

#func _init(_owner: Being, _conditions: Array[Condition]) -> void:
    #being = _owner;
    #conditions = _conditions;


func CheckConditions() -> void:
    var isCompleted = true;

    for condition in conditions:
        if !condition.IsCompleted():
            isCompleted = false;
    
    print(isCompleted)
    if isCompleted:
        status = Status.completed;


func CompleteQuest() -> void:
    print("Quest completed");
    #implement rewards system here somehow

func GetQuestString() -> String:
    var qString = str(self) + " is completed when ";

    for condition: Condition in conditions:
        var cString = str(condition.target) + " " + str(condition.attribute) + " is " + str(condition.value);
        qString += cString;

    return qString;
