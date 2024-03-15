extends RigidBody3D

var ball_sides = []
var selected
var ball_number = 0
var roll_player

## LOTTO BALL
## - Main purpose: is used in the Lotto Generator
## - Is a part of Lotto Ball Group, from which each of the selected balls
##   will be freed of (if they are selected by the generator)
## - When the lotto ball is selected, it will get gravity and thus get out of the machine

func _ready():
	selected = false
	roll_player = self.get_child(2)
	
func _physics_process(_delta):
	if selected == true:
		self.freeze = false
	
func show_ball_number(number):
	ball_sides = get_child(1).get_child(0).get_children()
	for bs in ball_sides:
		bs.text = str(number)
	ball_number = number
