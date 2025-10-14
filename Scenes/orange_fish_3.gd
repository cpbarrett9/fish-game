extends Sprite2D

@onready var sprite = $Sprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var node_main: Node = get_node("/root/Main")
	if node_main.getLives() < 3:
		queue_free()
	
