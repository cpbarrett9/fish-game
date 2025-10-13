extends Node2D

@export var xMin: int = -10
@export var xMax: int = 3010
@export var yMin: int = -10
@export var yMax: int = 2010
@export var minSeconds: float = 0
@export var maxSeconds: float = 0.5
@onready var fish_scene = preload("res://Scenes/Objects/npc_fish.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_fish(randf_range(minSeconds, maxSeconds)) # Spawns fish after 1-10 seconds (random)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fish(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	var spawnPosition: Vector2
	var travelSpeed: float
	var spawnSide: int = randi_range(1, 2)
	var fish_instance = fish_scene.instantiate()  # Create a new copy of Fish.tscn
	match spawnSide:
		1: #LEFT:
			spawnPosition = Vector2(xMin, randf_range(yMin, yMax)) # Spawn on left side
			travelSpeed = 3 # Spawned on left, so travel right
			fish_instance.get_node("Sprite2D").flip_h = false
			print("Spawn on left")
		2: #RIGHT:
			spawnPosition = Vector2(xMax, randf_range(yMin, yMax)) # Spawn on right side
			travelSpeed = -3 #Spawned on right, so travel left
			fish_instance.get_node("Sprite2D").flip_h = true #flip the sprite if the fish is travelling left
			print("Spawn on right")
	print("Spawned a fish")
	fish_instance.travelSpeed = travelSpeed
	fish_instance.position = spawnPosition
	add_child(fish_instance)                       # Add it to the current scene
	spawn_fish(randf_range(minSeconds, maxSeconds)) # Spawns fish after 1-10 seconds (random)
