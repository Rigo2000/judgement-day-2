extends GameObject;

var effectType: String;
var amount : int

func OnConsume(_being: Being):
    _being.effectType -= amount;