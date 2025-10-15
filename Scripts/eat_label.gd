extends Label

@onready var smallFish: Sprite2D = $GreenFish
@onready var medFish: Sprite2D = $YellowFish
@onready var medFishShader = preload("res://Materials/medium_fish_shader.tres")
@onready var largeFish: Sprite2D = $RedFish
@onready var largeFishShader = preload("res://Materials/large_fish_shader.tres")
@onready var node_main: Node2D = $"../.."
@onready var player = $"../../PlayerFish"
@onready var thoughtBubble = $"../../PlayerFish/ThoughtBubble"

var hasReachedMedium: bool = false
var hasReachedLarge: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	medFish.material = null # <- Null material = no color
	largeFish.material = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.getSize() == 2 && !hasReachedMedium:
		activateMedFish()
		thoughtBubble.appear()
		hasReachedMedium = true
	if player.getSize() == 3 && !hasReachedLarge:
		activateLargeFish()
		thoughtBubble.appear()
		hasReachedLarge = true

# Adding materials/shaders to fish (colors them in)
func activateMedFish() -> void:
	medFish.material = medFishShader
func activateLargeFish() -> void:
	largeFish.material = largeFishShader
