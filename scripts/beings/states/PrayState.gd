extends BeingState;

var elapsedTime;
var coolDown: float = 5.0;

func EnterState(_target: GameObject = null, _next_state: String = "null") -> void:
    elapsedTime = 0.0;
    print(str(being) + " entered pray state");

func ExitState() -> void:
    print(str(being) + " exited pray state");

func Update() -> void:
    pass ;

func MakePrayer() -> Quest:
    return Quest.new();
