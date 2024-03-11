extends Control

var selected = false
var clickCount = 0
@onready var animation = $AnimationPlayer


var flip1_has_played = false
var flip2_has_played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected and !flip1_has_played:
		self.get_child(0).visible = true
		animation.play("flip_1")
		await get_tree().create_timer(0.5).timeout
		flip1_has_played = true
		
	if selected and flip1_has_played and !flip2_has_played:
		self.get_child(0).visible = false
		self.get_child(1).visible = true
		self.get_child(2).visible = true
		animation.play("flip_2")
		await get_tree().create_timer(0.5).timeout
		flip2_has_played = true
		
func _on_button_pressed():
	self.selected = true
