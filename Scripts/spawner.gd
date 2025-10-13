extends Node2D

@export var xMin: int = 0
@export var xMax: int = 3000
@export var yMin: int = 0
@export var yMax: int = 2000
@onready var fish_scene = preload("res://Scenes/Objects/npc_fish.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_fish(randf_range(1, 5)) # Spawns fish after 1-10 seconds (random)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fish(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	var spawnSide: int = randi_range(1, 2)
	#match spawnSide:
		#1: 
	print("Spawned a fish")
	var fish_instance = fish_scene.instantiate()  # Create a new copy of Fish.tscn
	fish_instance.position = Vector2(randf_range(1, 1100), randf_range(1, 600))     # Set its position in world space
	add_child(fish_instance)                       # Add it to the current scene
	spawn_fish(randf_range(1, 5)) # Spawns fish after 1-10 seconds (random)
