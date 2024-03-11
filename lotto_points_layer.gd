extends Control

var point_icons

# Called when the node enters the scene tree for the first time.
func _ready():
	point_icons = self.get_child(0).get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
