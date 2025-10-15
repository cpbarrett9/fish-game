extends Node2D

@onready var allImages = $UI/Images
@onready var allText = $UI/Title
@onready var background = $UI/SpriteMenuBg
var movement: bool = false
var swipeSpeed: float = 100
@onready var game = preload("res://Scenes/Levels/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click_left"):
		_startGame()
	if movement:
		allImages.position.y += swipeSpeed
		allText.position.y -= swipeSpeed
		background.modulate.a = background.modulate.a-0.5

func _startGame():
	movement = true
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/main.tscn")
