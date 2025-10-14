extends CanvasLayer

@onready var player = $"../PlayerFish"
@onready var camera = $"../PlayerFish/Camera2D"
@onready var overlay = $"Dim Overlay"

var fadeIn: bool = false
var fadeOut: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Fade in:
	if fadeIn && overlay.modulate.a < 1:
		overlay.modulate.a = min(overlay.modulate.a + delta * 2, 1.0)
	if fadeIn && overlay.modulate.a >= 1:
		fadeIn = false
	
	#Fade out:
	if fadeOut && overlay.modulate.a > 0:
		overlay.modulate.a = max(overlay.modulate.a - delta * 2, 0.0)
	if fadeOut && overlay.modulate.a <= 0:
		fadeOut = false
	
func doFadeIn() -> void:
	fadeIn = true

func doFadeOut() -> void:
	fadeOut = true
