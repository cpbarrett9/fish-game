extends Node2D

# Plays win sound and fades BGM on win

@onready var bgmGame = $BgmGame
var fadeBGM: bool = false
@onready var sfx_win = $SfxWin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#playWin()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fadeBGM: bgmGame.volume_db -= 0.2

func playWin() -> void:
	sfx_win.play()
	fadeBGM = true
