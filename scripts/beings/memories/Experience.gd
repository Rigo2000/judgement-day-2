class_name Experience;

var event: GameEvent;
var type: Type;

func SetEvent(_event: GameEvent) -> Experience:
    event = _event;
    return self;

func SetEvent(_type: Type) -> Experience:
    type = _type;
    return self;

enum Type {
    see,
    feel,
}