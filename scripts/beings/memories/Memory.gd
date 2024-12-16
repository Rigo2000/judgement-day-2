class_name Memory;

var description: String = "";

var event: GameEvent;
var time: int;
var location: int;


func SetEvent(_event: GameEvent) -> Memory:
    event = _event;

    return self;

func SetTime(_time: int) -> Memory:
    time = _time;
    return self;


func SetLocation(_location: int) -> Memory:
    location = _location;
    return self;
