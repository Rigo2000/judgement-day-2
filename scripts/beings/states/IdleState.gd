extends BeingState;

var timeElapsed;
var coolDown = 1.0;

func EnterState(_target: GameObject = null, _next_state: String = "null") -> void:
    timeElapsed = 0.0;
    GlobalEvents.emit_signal("beingUpdate", GameEvent.new(being, "beingEnteredIdleState"));
    print(str(being) + " entered idle state");

func ExitState() -> void:
    print(str(being) + " exited idle state");

func Update(delta) -> void:
    
    timeElapsed += delta;

    if timeElapsed >= coolDown:
        being.hunger -= 10;
        #print(str(being.hunger))
        timeElapsed = 0.0;

    if being.hunger < 40:
        being.ChangeState("EatState");
    pass ;