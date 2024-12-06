extends GameObject;

var effectType: String;
var amount: int


func RequestFromResources(resourceData: ResourceData) -> ResourceData:
    ##A hack that is needed for the setter to work
    return super(resourceData);
