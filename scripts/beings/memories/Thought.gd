class_name Thought;

var type: Type;
var experience: Experience;

func SetType(_type: Type) -> Thought:
    type = _type;
    return self;

func SetExperience(_experience: Experience) -> Thought:
    experience = _experience;
    return self;

func GetDescription() -> String:
    return ""


enum Type {
    happy,
    sad,
    angry,
    depressed,
    euphoric,
    inspired,
    awestruck,
    in_love,
}
