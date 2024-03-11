extends Node2D

var is_selected = false
var has_moved = false
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_selected and not has_moved:
		animation.play("lotto_ball_move")
		await get_tree().create_timer(1).timeout
		has_moved = true
		
		
