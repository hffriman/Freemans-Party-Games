extends RigidBody3D

var is_rotating = true
var diceRB
var number_detectors = []

# Called when the node enters the scene tree for the first time.
func _ready():
	diceRB = get_node(".")
	
	for _i in self.get_child(1).get_children():
		number_detectors.append(_i.get_child(0))
	
func _process(_delta):
	if (is_rotating):
		diceRB.freeze = true
		diceRB.rotate(Vector3(0, 1.0, 0), 0.9)
		# Make a smooth rotation to the dice
		
	elif !(is_rotating):
		diceRB.freeze = false
		# Make sure that the dice will stop rotating after being released

func _check_readiness(ready, rotating):
	if ready && rotating:
		self.is_rotating = false
		self.apply_impulse(Vector3(0, 30000, -30000), Vector3(0, 0, 0))

func _check_result():
	for detector in number_detectors:
		if detector.is_colliding():
			if(detector.get_collider().name == "Roof"):
				return(int(str(detector.name)))
