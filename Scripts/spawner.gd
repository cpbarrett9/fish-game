extends Node2D

@export var xMin: int = -30
@export var xMax: int = 1730
@export var yMin: int = 30
@export var yMax: int = 850
@export var minSeconds: float = 0
@export var maxSeconds: float = 1
@onready var fish_scene_small = preload("res://Scenes/Objects/npc_fish_small.tscn")
@onready var fish_scene_medium = preload("res://Scenes/Objects/npc_fish_medium.tscn")
@onready var fish_scene_large = preload("res://Scenes/Objects/npc_fish_large.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_fish(randf_range(minSeconds, maxSeconds)) # Spawns fish after 1-10 seconds (random)
	var delay = randf() * 2.0  # up to 2 seconds random delay
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fish(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	var spawnPosition: Vector2
	var travelSpeed: float
	var fish_instance
	var spawnSide: int = randi_range(1, 2)
	
	# SMALL, MEDIUM, OR LARGE?
	var rng: int = randi_range(1, 10) # Randomly determine size of fish to spawn
	if rng <= 5: fish_instance = fish_scene_small.instantiate()  # Create a new copy of Fish.tscn
	elif rng <= 9: fish_instance = fish_scene_medium.instantiate()
	else: fish_instance = fish_scene_large.instantiate()
	
	# LEFT OR RIGHT?
	match spawnSide:
		1: #LEFT:
			spawnPosition = Vector2(xMin, randf_range(yMin, yMax)) # Spawn on left side
			travelSpeed = 3 # Spawned on left, so travel right
			fish_instance.get_node("Sprite2D").flip_h = false
			print("Spawn on left")
		2: #RIGHT:
			spawnPosition = Vector2(xMax, randf_range(yMin, yMax)) # Spawn on right side
			travelSpeed = -3 #Spawned on right, so travel left
			fish_instance.get_node("Sprite2D").flip_h = true
			print("Spawn on right")
	
	# SPAWN FISH OF APPROPRIATE TYPE WITH APPROPRIATE PARAMETERS:
	print("Spawned a fish")
	fish_instance.travelSpeed = travelSpeed
	fish_instance.position = spawnPosition
	add_child(fish_instance)                       # Add it to the current scene
	spawn_fish(randf_range(minSeconds, maxSeconds)) # Spawns fish after 1-10 seconds (random)
