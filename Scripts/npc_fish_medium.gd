extends Area2D

@onready var sprite = $Sprite2D
@onready var main: Node2D = get_tree().get_root().get_node("Main")
@export var travelSpeed: float = randf_range(2,4)
@export var pointValue: int = 5
@onready var tween = create_tween() # For bobbing fish animation
@export var fish_size: int = 2

@export var bob_height: float = 50.0    # vertical amplitude
@export var bob_speed: float = 2.0      # vertical frequency
@onready var player = get_tree().get_root().get_node("Main/PlayerFish")

var base_y: float
var time: float = 0.0
var bob_offset: float = 0.0             # random start offset

# LOAD ALL POSSIBLE TEXTURES INTO AN ARRAY:
var fish_textures = [
	preload("res://Sprites/sprite_fish2.png"),
	preload("res://Sprites/sprite_fish7.png"),
	preload("res://Sprites/sprite_fish1.png"),
]

func _ready() -> void:
	# Choose a random texture:
	randomize()
	var random_index = randi() % fish_textures.size()
	sprite.texture = fish_textures[random_index]
	connect("body_entered", Callable(self, "_on_body_entered"))
	bob()
	
	randomize()  
	base_y = position.y
	bob_offset = randf() * TAU            # randomize starting point 

func getSprite() -> Sprite2D:
	return sprite

func _process(delta: float) -> void:
	position.x += travelSpeed
	# horizontal movement
	# vertical bobbing using sine wave
	time += delta * bob_speed
	position.y = base_y + sin(time + bob_offset) * bob_height

func _on_body_entered(body: Node) -> void:
	var node_main: Node = get_node("/root/Main")
	if body.name == "PlayerFish": # Trigger when player collides with fish
		if fish_size <= player.getSize():
			node_main.set_score(pointValue)
			print(str(main.score))
			queue_free()

func bob() -> void:
	var tween = create_tween().set_loops()
	var up_y = position.y - 10
	var down_y = position.y + 10
	
	tween.tween_property(self, "position:y", up_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", down_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
