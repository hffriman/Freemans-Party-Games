extends Node2D

var ready_to_move
var score_is_shown

# Called when the node enters the scene tree for the first time.
func _ready():
	ready_to_move = false
	score_is_shown = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.ready_to_move:
		if self.position.y <= -369:
			self.position.y += 650 * _delta
		elif self.position.y == -369:
			score_is_shown = true

func _ready_to_show_score(dice):
	if dice.sleeping && !dice.is_rotating:
		var score = dice._check_result()
		self.visible = true
		self.get_child(1).text = str(score)
		self.ready_to_move = true
