extends BeingState;

##TAKES AN INCOMING TASK AND DETERMINES WHAT KIND OF 
##OBJECT IT NEEDS TO FIND
##THEN RETURNS THE OBJECT TO THE INCOMING TASK?

func EnterState() -> void:
	pass ;
	

func ExitState() -> void:
	pass ;

func Update() -> void:
	var searchTask: Task = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Search")];

	if searchTask.initiatorTask != null:


		if searchTask.initiatorTask.target != null:
			being.chainedTask.erase(searchTask);
			being.ChangeState("IdleState");

		##FIND SOCIALIZE
		if searchTask.initiatorTask.taskType == "Socialize":
			var positons: Array[Node2D] = GetPositionsWithinView();

			var beingsInView: Array[GameObject] = [];

			for p in positons:
				for obj: GameObject in GameManager.positionsNode.get_children()[p].get_children():
					if obj.type == "Being":
						beingsInView.append(obj);
			
			for b in beingsInView:
				if b.chainedTask.has(func(x): return x.taskType == "Socialize"):
					searchTask.initiatorTask.target = b;
					##TODO GET OUT OF THE THING 
					being.chainedTask.erase(searchTask);
					being.ChangeState("IdleState");
		
		##FIND RESOURCE
		if searchTask.initiatorTask.taskType == "Gather":
			var positons: Array[Node2D] = GetPositionsWithinView();

			var objectsInView: Array[GameObject] = [];

			#Potential delivertarget
			var deliverTarget: GameObject = being.chainedTask[being.chainedTask.find(func(x): return x.taskType == "Deliver")].target;

			for p in positons:
				##Add all objects to objects in view
				for obj: GameObject in GameManager.positionsNode.get_children()[p].get_children():
						objectsInView.append(obj);

			##START FILTERING
			objectsInView.filter(func(x): return x.type != "Being");
			objectsInView.filter(func(x): return x != deliverTarget);
			objectsInView.filter(func(x):
				if x.status != null:
					if x.status != Building.BuildingStatus.UNDER_CONSTRUCTION:
						return x
				)
		
			#FInd the nearest
			searchTask.initiatorTask.target = FindNearestObject(objectsInView);
			being.chainedTask.erase(searchTask);
			being.ChangeState("IdleState");


func GetPositionsWithinView() -> Array[Node2D]:
	var minPos = clampi(being.GetPositionNodeIndex() - being.viewDistance, 0, 99);
	var maxPos = clampi(being.GetPositionNodeIndex() + being.viewDistance, 0, 99);

	var positionsInView = []

	for p in GameManager.positionsNode.get_child_count():
		##IF BEING CAN SEE POISITONS
		if p >= minPos and p <= maxPos:
			positionsInView.append(p);

	return positionsInView;

func FindNearestObject(objects) -> GameObject:
	var minDist = 1000;
	var targetObj = null;
	
	for obj in objects:
		if abs(being.GetPositionNodeIndex() - obj.GetPositionNodeIndex()) < minDist:
			targetObj = obj;
			minDist = abs(being.GetPositionNodeIndex() - obj.GetPositionNodeIndex());

	return targetObj;
