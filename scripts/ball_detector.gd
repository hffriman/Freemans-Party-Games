extends Area3D

var ball_fall_sound_player

##  BALL DETECTOR
##  - Main purpose: detects the lottery ball that falls from the machine
##  --> plays both the falling sound (_on_body_entered) and rolling sound (_on_body_exited)
##  - Used in Lotto Generator, as a part of Lottery Machine

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_fall_sound_player = get_node("BallFallSound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("lotto_ball"):
		ball_fall_sound_player.playing = true

func _on_body_exited(body):
	if body.is_in_group("lotto_ball"):
		body.get_child(2).playing = true
