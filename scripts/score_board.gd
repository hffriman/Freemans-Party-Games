extends Node2D

var ready_to_move
var score_is_shown

## SCORE BOARD
## - Main purpose: Shows the value of the dice after it is thrown
## - Moves to the screen from up to down with animation
## - After the score boards have moved completely to the screen, 
##   the Final Phase Layer is immediately activated by the dicegame.gd

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
