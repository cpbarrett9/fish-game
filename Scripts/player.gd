extends Node2D

@export var score: int = 0
@export var speed: float = 5.0  # Higher = faster follow
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	# Get mouse position and float towards it
	var target = get_global_mouse_position()
	position = position.lerp(target, speed * delta)
	
	# Flip sprite depending on position of mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x < global_position.x:
		sprite.flip_h = true   # face left
	else:
		sprite.flip_h = false  # face right
