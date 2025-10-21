extends Sprite2D

# I think I attached this to the fish sprites in the main menu but I'm not sure

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bob()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= 300 * delta
	if position.x <= -200: position.x = 1800

func bob() -> void:
	var tween = create_tween().set_loops()
	var up_y = position.y - 10
	var down_y = position.y + 10
	
	tween.tween_property(self, "position:y", up_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", down_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
