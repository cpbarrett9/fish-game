extends Label

@onready var main_node = get_node("/root/Main")  # Adjust path as needed

func _ready():
	text = "Lives: "
	
