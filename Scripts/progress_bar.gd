extends ProgressBar

@onready var main_node = $"../.."
@onready var playerScore: int
@onready var player = $"../../PlayerFish"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = player.scoreToWin
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerScore: int = main_node.getScore()
	set_value(playerScore)
