extends Area2D

@onready var sprite = $Sprite2D
@onready var main: Node2D = get_tree().get_root().get_node("Main")
@export var travelSpeed: float = 1
@export var pointValue: int = 5

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta: float) -> void:
	position.x += travelSpeed

func _on_body_entered(body: Node) -> void:
	if body.name == "PlayerFish": # Trigger when player collides with fish
		print("The player fish touched the NPC fish!")
		main.score += pointValue
		print(str(main.score))
		queue_free()
