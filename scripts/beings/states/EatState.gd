extends BeingState;

var timeElapsed;
var eatCooldown = 1.0;

var foodTarget;

func EnterState(_target: GameObject = null, _next_state: String = "null") -> void:
	timeElapsed = 0.0;
	print(str(being) + " entered the eat state");

	if !CheckForFoodOnCurrentPos():
		##FIND FOOD SOURCE
		var minPos = clampi(being.GetPositionNodeIndex() - being.viewDistance, 0, 19);
		var maxPos = clampi(being.GetPositionNodeIndex() + being.viewDistance, 0, 19);

		var foodObjectsInView = []

		##GET ALL POSITIONS
		for p in GameManager.positionsNode.get_child_count():
			##IF BEING CAN SEE POISITONS
			if p >= minPos and p <= maxPos:
				##GET ALL OBJECTS ON THAT POSITION
				for obj: GameObject in GameManager.positionsNode.get_children()[p].get_children():
					if obj.type == "FoodType":
						foodObjectsInView.append(obj);
				pass ;
	

		print(foodObjectsInView.size());


		var minDist = 1000;
		var targetObj = null;

		##CHECK WHICH POSITION WITH FOOD IS NEAREST
		for obj in foodObjectsInView:
			if abs(being.GetPositionNodeIndex() - obj.GetPositionNodeIndex()) < minDist:
				targetObj = obj;
				minDist = abs(being.GetPositionNodeIndex() - obj.GetPositionNodeIndex());
		
		##IF POS WITH FOOD, MOVE TOWARDS	
		if targetObj != null:
			print("targertobject is " + str(targetObj))
			being.ChangeState("MoveState", targetObj, "EatState");
		## IF THERES NO FOOD IN SIGHT, START WANDERING
		#elif targetObj == null:
		#	var randomPos = clamp(being.pos + randi_range(-being.viewDistance, being.viewDistance), 0, 19);
		#	being.ChangeState("MoveState", randomPos, "EatState");

	else:
		for obj in GameManager.positionsNode.get_children()[being.GetPositionNodeIndex()].get_children():
			if obj.type == "FoodType":
				foodTarget = obj;
			
	
func ExitState() -> void:
	print(str(being) + " exited the eat state");

func Update(delta) -> void:
	timeElapsed += delta;

	if being.hunger >= 100:
		being.ChangeState("IdleState");

	elif timeElapsed >= eatCooldown:
		#if food is still there, eat it
		if foodTarget != null:
			print(str(being) + " eats")
			GlobalEvents.emit_signal("beingUpdate", GameEvent.new(being, "beingHasEaten"));
			being.hunger += 50;
			timeElapsed = 0.0;
		#otherwise go to idlestate
		else:
			being.ChangeState("IdleState");


func CheckForFoodOnCurrentPos() -> bool:
	##CHECK IF FOOD IS ON CURRENT POS
	for obj in GameManager.positionsNode.get_children()[being.GetPositionNodeIndex()].get_children():
		if obj.type == "FoodType":
			return true;

	return false;
