extends Label

@onready var smallFish: Sprite2D = $GreenFish
@onready var medFish: Sprite2D = $YellowFish
@onready var medFishShader = preload("res://Materials/medium_fish_shader.tres")
@onready var largeFish: Sprite2D = $RedFish
@onready var largeFishShader = preload("res://Materials/large_fish_shader.tres")
@onready var node_main: Node2D = $"../.."

var hasReachedMedium: bool = false
var hasReachedLarge: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	medFish.material = null
	largeFish.material = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if node_main.getSize() == 2 && !hasReachedMedium:
		activateMedFish()
		hasReachedMedium = true
	if node_main.getSize() == 3 && !hasReachedLarge:
		activateLargeFish()
		hasReachedLarge = true
	
func activateMedFish() -> void:
	medFish.material = medFishShader

func activateLargeFish() -> void:
	largeFish.material = largeFishShader
