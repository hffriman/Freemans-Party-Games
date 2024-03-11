extends Area3D

var is_activated

# Called when the node enters the scene tree for the first time.
func _ready():
	is_activated = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("lotto_ball"):
		is_activated = true
