extends CharacterBody2D

@export var speed: float = 5.0  # Higher = faster follow
@onready var sprite = $Sprite2D
@onready var size: int = 1
@onready var node_main: Node = get_node("/root/Main")
@onready var collisionpolygon = $CollisionPolygon2DTEST
@onready var characterbody = $CharacterBody2D

# Scores thresholds triggering sizes + tracking booleans:
@export var scoreToWin = 300
var winTriggered: bool = false
@export var scoreForLarge = 150
var largeTriggered: bool = false
@export var scoreForMedium = 50
var mediumTriggered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func getSize() -> int:
	return size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var score = node_main.getScore() # Update score (from Main node) every frame
	
	# Check when to increase size when a score thresholds are reached:
	if score > scoreToWin && !winTriggered: 
		print("Game won!")
		winTriggered = true
	if score > scoreForLarge && !largeTriggered: 
		size = 3 #3 = LARGE
		largeTriggered = true
	if score > scoreForMedium && !mediumTriggered: 
		size = 2 #2 = SMALL
		mediumTriggered = true
	
	# Get mouse position and float towards it
	var target = get_global_mouse_position()
	position = position.lerp(target, speed * delta)
	
	# Flip sprite depending on position of mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x < global_position.x:
		sprite.flip_h = true   # face left
	else:
		sprite.flip_h = false  # face right
	
	# Increasing size based on score:
	if node_main.getScore() >= 20 && node_main.getScore() < 60:
		growSize(1.2, 1.2)
		node_main.incrementSize
	if node_main.getScore() >= 40:
		growSize(1.4, 1.4)
		node_main.incrementSize
	if node_main.getScore() >= 60:
		growSize(1.6, 1.6)
		node_main.incrementSize
	if node_main.getScore() >= 80:
		growSize(1.8, 1.8)
		node_main.incrementSize
	if node_main.getScore() >= 100:
		growSize(2, 2)
		node_main.incrementSize
	if node_main.getScore() >= 150:
		growSize(2.3, 2.3)
		node_main.incrementSize
	if node_main.getScore() >= 200:
		growSize(2.6, 2.6)
		node_main.incrementSize
	if node_main.getScore() >= 250:
		growSize(3, 3)
		node_main.incrementSize
	#if node_main.getScore() >= 1000:
		#growSize()
		#node_main.incrementSize
	#if node_main.getScore() >= 1000:
		#growSize()
		#node_main.incrementSize
	#if node_main.getScore() >= 1000:
		#growSize()
		#node_main.incrementSize
	#if node_main.getScore() >= 1000:
		#growSize()
		#node_main.incrementSize
	
	
func growSize(x: float, y: float):
	scale = Vector2(x, y)  # Doubles the size instantly
