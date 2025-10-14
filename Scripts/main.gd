extends Node2D

var score: int = 0
var playerSize: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func getScore() -> int:
	return score
	
func getSize() -> int:
	return playerSize
	
func setSize(newSize: int) -> void:
	playerSize = newSize

func incrementSize() -> void:
	playerSize = playerSize + 1


signal score_changed(new_score)
func set_score(value):
	score = value+score
	emit_signal("score_changed", score)
