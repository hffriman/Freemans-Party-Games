extends Node2D

var is_selected = false
var has_moved = false
@onready var animation = $AnimationPlayer


## LOTTO BALL ICON
## - Main purpose: show the value of the selected ball as an UI SPRITE
## - Whenever the lotto machine releases a new ball, the lotto ball icon is shown on the screen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_selected and not has_moved:
		animation.play("lotto_ball_move")
		await get_tree().create_timer(1).timeout
		has_moved = true
		
		
