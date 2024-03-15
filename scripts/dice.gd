extends RigidBody3D

var is_rotating = true
var diceRB
var number_detectors = []
var dice_roll_player

## DICE
## - Main purpose: is used in the Dice Game
## - The dice is in the air, rotating around its own axis,
##   until the function from dicegame.gd releases it
## - When dice is considered is "ready", it will be thrown
## - The dice has 6 raycast detectors (one for each of the dice's sides)
##   --> the detector that is shooting at the roof object is the result of the thrown dice
## - The dice also has audio for rolling, which is activated in DiceDetector.gd

# Called when the node enters the scene tree for the first time.
func _ready():
	diceRB = get_node(".")
	dice_roll_player = get_node("DiceRollPlayer")
	
	for _i in self.get_child(1).get_children():
		number_detectors.append(_i.get_child(0))
	
func _physics_process(_delta):
	if (is_rotating):
		diceRB.freeze = true
		diceRB.rotate(Vector3(0, 1.0, 0), 0.9)
		
	elif !(is_rotating):
		diceRB.freeze = false

func _check_readiness(ready, rotating):
	if ready && rotating:
		self.is_rotating = false
		self.apply_impulse(Vector3(0, 30000, -30000), Vector3(0, 0, 0))
		return true
		

func _check_result():
	for detector in number_detectors:
		if detector.is_colliding():
			if(detector.get_collider().name == "Roof"):
				return(int(str(detector.name)))

func _play_roll_sound():
	dice_roll_player.playing = true
	
func _stop_roll_sound():
	dice_roll_player.playing = false
