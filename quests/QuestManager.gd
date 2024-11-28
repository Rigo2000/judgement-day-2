class_name QuestManager;

extends Node;

@export var availableQuests: Node;
@export var activeQuests: Node;
@export var completedQuests: Node;

var questScene = preload("res://scenes/quest_scene.tscn");

func CreateNewQuest(being: Being, conditions: Array[Condition]) -> void:
	var newQuest = questScene.instantiate();
	newQuest.being = being;
	newQuest.conditions = conditions;
	newQuest.status = Quest.Status.active;
	activeQuests.add_child(newQuest);
	print(newQuest.GetQuestString())

func _ready() -> void:
	GlobalEvents.connect("beingUpdate", OnBeingUpdate);

func OnBeingUpdate(gameEvent: GameEvent) -> void:
	if !activeQuests.get_child_count() <= 0:
		for quest: Quest in activeQuests.get_children():
			for condition in quest.conditions:
				#print("Condition Target: " + str(condition.target) + " gameEvent.target " + str(gameEvent.target))
				if condition.target == gameEvent.target:
					condition.HandleGameEvent(gameEvent);
		
			quest.CheckConditions();
			if quest.status == Quest.Status.completed:
				quest.CompleteQuest();
				quest.get_parent().remove_child(quest);
				completedQuests.add_child(quest);
