extends RigidBody3D

var ball_sides = []
var selected
var ball_number = 0
var roll_player

func _ready():
	selected = false
	roll_player = self.get_child(2)
	
func _process(_delta):
	if selected == true:
		self.freeze = false
	
func show_ball_number(number):
	ball_sides = get_child(1).get_child(0).get_children()
	for bs in ball_sides:
		bs.text = str(number)
	ball_number = number
