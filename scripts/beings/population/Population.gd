class_name Population;

var beings: Dictionary;

var buildings: Dictionary;
var townSquare: GameObject:
    get:
       return buildings["townSquare"];

var resources: Dictionary:
    get:
        return buildings["townSquare"].inventory;

var taskQueue: Array = [];

func AddNewTask():
    pass ;

func DetermineTask():
    ##Check if food is low
    ##Probably make a more complex check for that
    if resources["food"] < 20:
        pass ;
    #Else check if wood is low, also by looking at wood available vs how much is needed for current tasks
    elif resources["wood"] < 20:
        pass ;