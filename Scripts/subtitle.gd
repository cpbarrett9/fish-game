extends Label

var opaque: bool = true
var blink: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_doBlink()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if opaque: modulate.a = 1
	elif blink: modulate.a = 0.6

func _doBlink() -> void:
	opaque = true
	blink = false
	await get_tree().create_timer(0.5).timeout
	opaque = false
	blink = true
	await get_tree().create_timer(0.5).timeout
	_doBlink()
