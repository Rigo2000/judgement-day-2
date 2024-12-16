class_name GameEvent;

var time;
var location;
var objects;
var eventType;
var being;

enum Type {
    birth,
    death,
    violence,
    fire,
    rain,
    sickness,
    finish_task,
    pray,
    eat,
    gather,
    build,
    sleep,
    move,
    wander,
    socialize,
    deliver,
}

func SetTime(_time: int) -> GameEvent:
    time = _time;
    return self;

func SetLocation(_location: int) -> GameEvent:
    location = _location;
    return self;

func SetType(_type: Type) -> GameEvent:
    type = _type;
    return self;

func SetType(_type: Type) -> GameEvent:
    type = _type;
    return self;

func SetBeing(_being: Type) -> GameEvent:
    being = _being;
    return self;