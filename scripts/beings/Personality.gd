class_name Personality

extends Object

# Define personality traits with default scores
var traits: Dictionary = {
    "friendliness": 50, # How likely the being is to help or socialize
    "curiosity": 50, # How driven they are to explore or discover
    "aggression": 50, # Tendency to resort to violence or dominance
    "industriousness": 50, # Willingness to work hard or perform tasks
    "laziness": 50, # Preference for avoiding tasks or resting
    "cautiousness": 50, # Avoids risks or danger
    "empathy": 50, # Ability to understand and help others
    "bravery": 50, # Willingness to take risks or face danger
    "spirituality": 50, # Tendency to pray, worship, or seek divine favor
}

# Emotional states (these can dynamically change based on events)
var emotions: Dictionary = {
    "happiness": 50, # General emotional state
    "anger": 0, # Build-up over time or from events
    "fear": 0, # Reaction to danger or uncertainty
    "stress": 0, # Pressure from tasks or negative events
}

# Constructor
func _init(initial_traits: Dictionary = {}, initial_emotions: Dictionary = {}):
    # Allow initialization with custom trait and emotion values
    for t in traits.keys():
        if initial_traits.has(t):
            traits[t] = clamp(initial_traits[t], 0, 100);

    for e in emotions.keys():
        if initial_emotions.has(e):
            emotions[e] = clamp(initial_emotions[e], 0, 100);

# Get a trait score
func get_trait(trait_name: String) -> int:
    return traits.get(trait_name, -1) # Returns -1 if trait doesn't exist

# Set a trait score
func set_trait(trait_name: String, value: int):
    if traits.has(trait_name):
        traits[trait_name] = clamp(value, 0, 100)

# Adjust a trait by a given amount
func adjust_trait(trait_name: String, amount: int):
    if traits.has(trait_name):
        traits[trait_name] = clamp(traits[trait_name] + amount, 0, 100)

# Get an emotion score
func get_emotion(emotion_name: String) -> int:
    return emotions.get(emotion_name, -1) # Returns -1 if emotion doesn't exist

# Set an emotion score
func set_emotion(emotion_name: String, value: int):
    if emotions.has(emotion_name):
        emotions[emotion_name] = clamp(value, 0, 100)

# Adjust an emotion by a given amount
func adjust_emotion(emotion_name: String, amount: int):
    if emotions.has(emotion_name):
        emotions[emotion_name] = clamp(emotions[emotion_name] + amount, 0, 100)

# Randomize traits for a new being
func randomize_traits():
    for t in traits.keys():
        traits[t] = randi_range(0, 100)

# Generate offspring traits (merge two sets of traits)
func merge_traits(parent1: Personality, parent2: Personality):
    for t in traits.keys():
        traits[t] = clamp(
            (parent1.get_trait(t) + parent2.get_trait(t)) / 2 + randi_range(-10, 10), 0, 100
        )

# React to an event (adjust emotions and possibly traits)
func react_to_event(event_type: String):
    match event_type:
        "danger":
            adjust_emotion("fear", 20)
            adjust_emotion("stress", 10)
        "success":
            adjust_emotion("happiness", 15)
            adjust_emotion("stress", -10)
        "conflict":
            adjust_emotion("anger", 20)
            adjust_emotion("happiness", -10)
        "spiritual_blessing":
            adjust_emotion("happiness", 30)
            adjust_emotion("stress", -15)
            adjust_trait("spirituality", 5)

# Debugging: Print all traits and emotions
func debug_print():
    print("Traits:")
    for t in traits.keys():
        print("- " + t + ": " + str(traits[t]))
    print("Emotions:")
    for emotion in emotions.keys():
        print("- " + emotion + ": " + str(emotions[emotion]))
