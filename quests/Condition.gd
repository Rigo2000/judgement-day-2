class_name Condition;

#This is a base class.
#Attribute will be a s tring, and for different objects, like beings
#and buildings, and whatever, the IsCompleted function will
#have specific things to check for
#it's more problematic to use string
#but easier to implement for different things

var target: Being;
var attribute: String;
var value;

func _init(_target: Being, _attribute: String, _value) -> void:
	target = _target;
	attribute = _attribute;
	value = _value;

func HandleGameEvent(gameEvent: GameEvent) -> void:
	if gameEvent.target == target:
		IsCompleted();


func IsCompleted() -> bool:
	match attribute:
		"health":
			if target.health >= value:
				return true;
		"hunger":
			if target.hunger >= value:
				return true;
		"age":
			if target.age >= value:
				return true;
	return false;
