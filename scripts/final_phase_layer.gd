extends CanvasLayer

var win_sound
var almost_sound
var lose_sound

## FINAL PHASE LAYER
## - MAIN PURPOSE: ORCHESTRATES THE FINAL PART OF THE DICE GAME
## - Consists of 3 parts: "Guess Number Layer", "Select Operator Layer" and "Game Over Layer"
## - All of the functionalities of this script are activated by dicegame.gd
## 1. When the dices are thrown and their values are shown on the screen,
##    the "Guess Number Layer" activates: the player must type a number between 1-12
## 2. When the player has typed their number, the "SelectOperatorCardLayer" activates:
##    the player must draw one of the 5 operator cards (+, -, *, /, an ^)
## 3. When the player has drawn a card, its value is then used to calculate the final score
##    of the game: after that, the "Game Over Layer" activates, and all the details are shown
## - Final Phase Layer also has three sound players, as well as its own rating based on the score

# Called when the node enters the scene tree for the first time.
func _ready():
	win_sound = get_node("GameOverLayer/WinSound")
	almost_sound = get_node("GameOverLayer/AlmostSound")
	lose_sound = get_node("GameOverLayer/LoseSound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _start_number_guess(guess_number):
	self.get_child(0).visible = true
	if guess_number != null:
		self.get_child(0).visible = false
		self.get_child(1).visible = true
		self.get_child(1).get_child(1).text = "You guessed: " + str(guess_number)

func _shuffle_operators(operators):
	for _i in self.get_child(1).get_child(0).get_children():
		var total_operators = operators.size()
		var randomized_number
		for total_operator in total_operators: 
			randomized_number = randi() % total_operators
		var chosen_operator = operators[randomized_number]
		_i.get_child(2).text = chosen_operator
		operators.erase(chosen_operator)
		total_operators -= 1

func _check_card_selection():
	var operator = ''
	for _i in self.get_child(1).get_child(0).get_children():
		if _i.selected:
			operator = _i.get_child(2).text
	return operator
	
func _make_final_calculation(final_operator, score1, score2):
	var final_score = ''
	for _i in self.get_child(1).get_child(0).get_children():
		if _i.selected:
			final_operator = _i.get_child(2).text
			match final_operator:
				'+':
					final_score = score1 + score2
				'-':
					final_score = score1 - score2
				'*':
					final_score = score1 * score2
				'/':
					final_score = float(score1) / float(score2)
					final_score = snapped(final_score, 0.01)
				'^':
					final_score = pow(score1, score2)
		elif !_i.selected:
			_i.get_child(3).disabled = true

		_show_score_in_the_corner(final_score)
	return final_score
	
func _give_final_rating(guess_number, score1, final_operator, score2, final_score):
	await get_tree().create_timer(0.5).timeout
	self.get_child(2).visible = true
	self.get_child(2).get_child(1).text = "You Guessed: " + str(guess_number)
	self.get_child(2).get_child(2).text = "The Result: " + str(score1) + str(final_operator) + str(score2) + " = " + str(final_score)
				
	var distance = abs(final_score - guess_number)
				
	if final_score == guess_number:
		self.get_child(2).get_child(3).text = "PERFECT!!"
		return "win"
	elif distance <= 2 && distance >=0 && distance <= 12:
		self.get_child(2).get_child(3).text = "SO CLOSE!!"
		return "almost"
	else:
		self.get_child(2).get_child(3).text = "GOOD LUCK NEXT TIME"
		return "lose"

func _show_score_in_the_corner(final_score):
	await get_tree().create_timer(0.8).timeout
	self.get_child(1).get_child(2).text = "Final Score: " + str(final_score)
