extends Node2D

var score: int = 0
var playerSize: int = 1
var numLives: int = 3
var invincible: bool = false
@onready var transition = $Transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#transition.doFadeOut()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reload_current_scene():
	var current_scene = get_tree().current_scene
	get_tree().change_scene_to_file(current_scene.scene_file_path)

func getScore() -> int:
	return score

func setScore(inputScore: int) -> void:
	score = inputScore
	
func getSize() -> int:
	return playerSize
	
func getLives() -> int:
	return numLives
	
func setSize(newSize: int) -> void:
	playerSize = newSize

func incrementSize() -> void:
	playerSize = playerSize + 1

#Invincibility code:
func invincibleOn() -> void:
	invincible = true
	print("Invincible on")
	
func invincibleOff() -> void:
	invincible = false
	print("Invincible off")
	
func isInvincible() -> bool:
	return invincible

signal score_changed(new_score)
func set_score(value):
	score = score+value
	emit_signal("score_changed", score)
	
