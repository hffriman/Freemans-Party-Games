extends Node3D

var game_ready; var game_over 
var dice1_ready; var dice2_ready

var dice1; var dice2
var score1; var score2; 
var final_score

var score_board1; var score_board2 
var final_phase_layer

var menu_layer

var guess_number
var final_operator; 
var operators; var operator_cards

var score_board1_is_shown; var score_board2_is_shown
var roof

# Called when the node enters the scene tree for the first time.
func _ready():
	game_ready = true
	game_over = false
	
	dice1_ready = false
	dice2_ready = false
	
	dice1 = get_node("Dice1")
	dice2 = get_node("Dice2")
		
	roof = get_node("Roof")
	
	score1 = null
	score2 = null
	guess_number = null
	final_score = null
	final_operator = null
	
	score_board1 = get_node("ScoreLayer/ScoreBoard1")
	score_board2 = get_node("ScoreLayer/ScoreBoard2")
	final_phase_layer = get_node("FinalPhaseLayer")
	menu_layer = get_node("MenuLayer")
	
	operators = ['+', '-', '*', '/', '^']
	
	final_phase_layer._shuffle_operators(operators)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	if game_ready:
		dice1._check_readiness(dice1_ready, dice1.is_rotating)
		dice2._check_readiness(dice2_ready, dice2.is_rotating)
		
		score1 = dice1._check_result()
		score2 = dice2._check_result()
		
		score_board1._ready_to_show_score(dice1)
		score_board2._ready_to_show_score(dice2)
		
		score_board1_is_shown = score_board1.position.y >= -368
		score_board2_is_shown = score_board2.position.y >= -368
		
		if score_board1_is_shown && score_board2_is_shown:
			await get_tree().create_timer(0.5).timeout
			final_phase_layer._start_number_guess(guess_number)
			final_operator = final_phase_layer._check_card_selection()
						
			if final_operator:
				final_score = final_phase_layer._make_final_calculation(final_operator, score1, score2)
				if int(final_score) <= 0 or int(final_score) >= 0:
					await get_tree().create_timer(2).timeout
					final_phase_layer._give_final_rating(guess_number, score1, final_operator, score2, final_score)
					menu_layer.visible = false
func _on_dice_button_1_pressed():
	dice1_ready = true

func _on_dice_button_2_pressed():
	dice2_ready = true

func _on_enter_number_button_pressed():
	var written_guess_number = get_node("FinalPhaseLayer/GuessNumberLayer/WriteGuessNumber").text
	if int(written_guess_number) >= 0 && int(written_guess_number) <= 12:
		guess_number = int(written_guess_number)
		
func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/dicegame.tscn")

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
