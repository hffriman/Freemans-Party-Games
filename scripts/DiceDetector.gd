extends Area3D


## DICE DETECTOR
## - Main purpose: recognizes the collisions between the dice and the board's surface
## - The dice's rolling sound will turn ON/OFF whenever the dice hits/leaves the board

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "Dice1" or body.name == "Dice2":
		body.get_child(4).playing =  true

func _on_body_exited(body):
	if body.name == "Dice1" or body.name == "Dice2":
		body.get_child(4).playing = false
