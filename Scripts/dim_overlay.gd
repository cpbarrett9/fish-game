extends Sprite2D

var fadingIn: bool = false
var fadingOut: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fadingIn == true: 
		modulate.a -= 0.05
		if modulate.a <= 0: fadingIn = false
	if fadingOut == true: 
		modulate.a += 0.05
		if modulate.a >= 1: fadingOut = false

func fadeIn() -> void:
	modulate.a = 1
	fadingIn = true
	
func fadeOut() -> void:
	modulate.a = 0
	fadingOut = true
