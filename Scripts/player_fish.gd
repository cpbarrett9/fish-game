extends CharacterBody2D

@export var 		speed: float = 5.0  # Higher = faster follow
@onready var 	sprite = $Sprite2D
@onready var 	size: int = 1
@onready var 	node_main: Node = get_node("/root/Main")
@onready var 	collisionpolygon = $CollisionPolygon2DTEST
@onready var 	characterbody = $CharacterBody2D

# Scores thresholds triggering sizes + tracking booleans:
@export var scoreToWin = 300
var winTriggered: bool = false
@export var scoreForLarge = 150
var largeTriggered: bool = false
@export var scoreForMedium = 50
var mediumTriggered: bool = false

# For disabling/enabling movement:
var movementEnabled: bool = true

# For tracking if the gameOver function is *currently* running:
var isGameOver: bool = false

###################################################################################################

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
	
	# Get mouse position and float towards it...
	if movementEnabled == true:
		var target = get_global_mouse_position()
		position = position.lerp(target, speed * delta)
	
	# Flip sprite depending on position of mouse
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x < global_position.x:
		sprite.flip_h = true   # face left
	else:
		sprite.flip_h = false  # face right
	
	# Increasing size based on score:
	var x: float = 1 + ( node_main.getScore()*0.01 )
	var y: float = 1 + ( node_main.getScore()*0.01 )
	scale = Vector2(x, y)
	
func gameOver():
	# Hide sprite / display message:
	if !isGameOver:
		isGameOver = true
		$CollisionPolygon2D.disabled = true # Disable collision so fish aren't getting eaten during gameover
		$CollisionShape2D.disabled = true
		sprite.visible = false
		movementEnabled = false
		node_main.numLives -= 1
		
		if node_main.numLives >= 0: # Repsawn if lives remain
			await get_tree().create_timer(3).timeout # Wait 3 seconds, then run RESPAWN code:
			
			# Reset score to last threshold achieved:
			if node_main.getScore() > scoreForLarge : node_main.setScore(scoreForLarge)
			elif node_main.getScore() > scoreForMedium : node_main.setScore(scoreForMedium)
			else: node_main.setScore(0)
			
			# Restore position and re-enable stuff
			$CollisionPolygon2D.disabled = false
			$CollisionShape2D.disabled = false
			sprite.visible = true
			movementEnabled = true
			position = Vector2(577, 325)
			$"../CanvasLayer/ScoreLabel".updateScoreManually() # Manually set the label to update to new score
			isGameOver = false
			
		else: # If not, then game over for real
			print("Game Over!")
