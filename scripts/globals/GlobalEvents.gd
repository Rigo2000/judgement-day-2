extends Node2D;

signal beingExperience(being: Being, experience: String);

signal beingUpdate(gameEvent: GameEvent);

signal newGameEven(gameEvent: GameEvent);

func HandleGameEvent(_gameEvent: GameEvent):
    if (gameEvent.location != null):
        var nearbyBeings = GameManager.population.beings.filter(func(x): return x.GetPositionNodeIndex() == location || x.GetPositionNodeIndex() == location - 1 || x.GetPositionNodeIndex() == location + 1);

        for being in nearbyBeings:
            being.HandleEvent(_gameEvent);