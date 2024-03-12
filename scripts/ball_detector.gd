extends Area3D

var ball_roll_sound_player

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_roll_sound_player = get_node("BallRollSound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("lotto_ball"):
		ball_roll_sound_player.playing = true
