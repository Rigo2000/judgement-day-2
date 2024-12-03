extends GameObject;

var effectType: String;
var amount: int

func TakeFromResources(_rData: ResourceData) -> ResourceData:
    health -= 50;
    return super(_rData);
