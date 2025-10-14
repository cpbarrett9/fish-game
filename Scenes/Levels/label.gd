extends Label

@onready var main_node = get_node("/root/Main")  # Adjust path as needed

func _ready():
	if main_node:
		main_node.connect("score_changed", Callable(self, "_on_score_changed"))
		text = "Score: " + str(main_node.score)

func _on_score_changed(new_score):
	text = "Score: " + str(new_score)
