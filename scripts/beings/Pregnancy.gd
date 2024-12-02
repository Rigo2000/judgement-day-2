class_name Pregnancy;

var count = 0;

func UpdatePregnancy():
    count += 1;

func IsCompleted() -> bool:
    if count >= 60:
        return true;
    else:
        return false;