extends Node2D

var fadein: bool = false
var fadeout: bool = false
@onready var sfx_idea = $"../../Audio/SfxIdea"
@onready var spr_redFish = $RedFish
@onready var spr_yellowFish = $YellowFish
@onready var spr_greenFish = $GreenFish
@onready var player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0
	await get_tree().create_timer(3).timeout
	appear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fadein && modulate.a < 1: modulate.a += 0.1
	if fadeout && modulate.a > 0: modulate.a -= 0.1
	
func appear() -> void:
	if player.getSize() == 1:
		spr_greenFish.visible = true
		spr_redFish.visible = false
		spr_yellowFish.visible = false
	elif player.getSize() == 2:
		spr_greenFish.visible = false
		spr_redFish.visible = false
		spr_yellowFish.visible = true
	elif player.getSize() == 3:
		spr_greenFish.visible = false
		spr_redFish.visible = true
		spr_yellowFish.visible = false
	sfx_idea.play()
	fadein = true
	await get_tree().create_timer(3).timeout
	fadein= false
	fadeout = true
	await get_tree().create_timer(3).timeout
	fadeout = false
