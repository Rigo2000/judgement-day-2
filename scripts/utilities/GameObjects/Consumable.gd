extends GameObject;

var effectType: String;
var amount: int

func TakeFromResources(_rData: ResourceData) -> ResourceData:
    ##A hack that is needed for the setter to work
    ChangeHealth(-20);
    return super(_rData);
