extends GameObject;

func RequestFromResources(resourceData: ResourceData) -> ResourceData:
    var returnObject = super(resourceData);

    if IsResourcesEmpty():
        DestroyObject();

    return returnObject;