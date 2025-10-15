extends Node2D

@onready var allImages = $UI/Images
@onready var allText = $UI/Title
@onready var background = $UI/SpriteMenuBg
var movement: bool = false
var swipeSpeed: float = 100
@onready var game = preload("res://Scenes/Levels/main.tscn")
@onready var splash = $Audio/sfx_splash
@onready var waves = $Audio/sfx_waves
@onready var bgm = $Audio/BgmMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click_left"):
		_startGame()
	if movement:
		allImages.position.y += swipeSpeed # <- Top half of menu graphics fly up
		allText.position.y -= swipeSpeed # <- Bottom half flys down
		background.modulate.a = background.modulate.a-0.5 # <- Waves bg fades away
		waves.volume_db -= 0.5 # <- BGM and SFX fade out
		bgm.volume_db -= 0.5

func _startGame():
	movement = true # <- Enable movement in _process
	splash.get_parent().remove_child(splash) # <- Move SFX node out of the scene so
	get_tree().get_root().add_child(splash) # it plays even when the scene changes
	splash.owner = get_tree().get_root()
	splash.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/main.tscn") # <- Load game
