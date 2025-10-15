extends Area2D

# OBSOLETE - But don't delete in case it breaks something

@onready var sprite = $Sprite2D
@onready var main: Node2D = get_tree().get_root().get_node("Main")
@export var travelSpeed: float = 1
@export var pointValue: int = 5
@onready var tween = create_tween() # For bobbing fish animation

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	bob()

func getSprite() -> Sprite2D:
	return sprite

func _process(delta: float) -> void:
	position.x += travelSpeed

func _on_body_entered(body: Node) -> void:
	var node_main: Node = get_node("/root/Main")
	if body.name == "PlayerFish": # Trigger when player collides with fish
		print("The player fish touched the NPC fish!")
		node_main.set_score(pointValue)
		print(str(main.score))
		queue_free()

func bob() -> void:
	var tween = create_tween().set_loops()
	var up_y = position.y - 10
	var down_y = position.y + 10
	
	tween.tween_property(self, "position:y", up_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", down_y, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
