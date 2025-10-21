extends Area2D

@onready var sprite = $Sprite2D
@onready var main: Node2D = get_tree().get_root().get_node("Main")
@export var travelSpeed: float = randf_range(140,200)
@export var pointValue: int = 10
@onready var tween = create_tween() # For bobbing fish animation
@export var fish_size: int = 3

@onready var player = get_tree().get_root().get_node("Main/PlayerFish")

# LOAD ALL POSSIBLE TEXTURES INTO AN ARRAY:
var fish_textures = [
	preload("res://Sprites/sprite_fish3.png"),
	preload("res://Sprites/sprite_fish4.png"),
]

func _ready() -> void:
	# Choose a random texture:
	randomize()
	var random_index = randi() % fish_textures.size()
	sprite.texture = fish_textures[random_index]
	connect("body_entered", Callable(self, "_on_body_entered"))
	bob()
	removeTimer()

func getSprite() -> Sprite2D:
	return sprite

func _process(delta: float) -> void:
	position.x += travelSpeed * delta

func _on_body_entered(body: Node) -> void:
	var node_main: Node = get_node("/root/Main")
	if body.name == "PlayerFish" && !player.getIsGameOver(): # Trigger when player collides with fish
		if fish_size <= player.getSize():
			node_main.set_score(pointValue)
			get_node("/root/Main/Audio/BiteSounds").play()
			queue_free()
		elif !node_main.isInvincible():
			player.gameOver()

func bob() -> void:
	var tween = create_tween().set_loops()
	var up_y = position.y - 10
	var down_y = position.y + 10
	
	tween.tween_property(self, "position:y", up_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", down_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func removeTimer() -> void:
	await get_tree().create_timer(20).timeout
	queue_free()
