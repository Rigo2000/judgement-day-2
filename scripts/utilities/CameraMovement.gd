extends Camera2D

# Variables for configuration
@export var edge_threshold: int = 50 # Distance from the edge in pixels
@export var camera_speed: float = 200 # Speed of camera movement (pixels per second)

func _process(delta):
    # Get the mouse position in the viewport
    var mouse_pos = get_viewport().get_mouse_position()
    var viewport_size = get_viewport().get_size()

    # Calculate camera movement
    var movement = Vector2.ZERO

    # Check edges
    if mouse_pos.x <= edge_threshold:
        if global_position.x > 100:
            movement.x -= 1 # Move left
    elif mouse_pos.x >= viewport_size.x - edge_threshold:
        if global_position.x < 1500:
            movement.x += 1 # Move right

    # Apply movement
    if movement != Vector2.ZERO:
        global_position += movement.normalized() * camera_speed * delta
