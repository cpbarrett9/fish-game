extends Sprite2D

# This is the waves background on the menu. It moves back and forward

func _ready() -> void:
	bob()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func bob() -> void: # Move left and right on tween animation (AI wrote this part)
	var tween = create_tween().set_loops()
	var up_x = position.x + 30
	var down_x = position.x - 30
	
	tween.tween_property(self, "position:x", up_x, 5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:x", down_x, 5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
