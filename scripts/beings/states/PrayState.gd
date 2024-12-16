extends BeingState;


func EnterState(_target: GameObject = null, _next_state: String = "null") -> void:
    pass ;
    #print(str(being) + " entered pray state");

func ExitState() -> void:
    pass ;
    #print(str(being) + " exited pray state");

func Update() -> void:
    var prayTask = being.chainedTask[(being.chainedTask.find(func(x): return x.taskType == "Pray"))];

    if prayTask != null:
        if being.personality.get_emotion("stress") < 80:
            var spiritualityFactor = being.personality.get_trait("spirituality");
            var stressAdjustment = (1 + spiritualityFactor * 2)
            being.personality.adjust_emotion("stress", stressAdjustment);
            return ;
        else:
            being.chainedTask.erase(prayTask);
            being.ChangeState("IdleState");
    pass ;
