extends Area3D

## DEADZONE
## - Main purpose: destroys all the lotto balls that become useless in the game
## - Is used in Lotto Generator, under the lotto machine's bridge object

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("lotto_ball"):
		body.queue_free()
