extends Node3D

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
	11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 
	31, 32, 33, 34, 35, 36, 37, 38, 39, 40]

var loading_screen

var lotto_ball_rows
var lotto_balls = []
var balls_ready = false

var press_count = 0
var lotto_turns = 7

var lotto_points_icons

var pick_button_is_pressed = false

var balls_left_label
var picking_a_ball_label
var balls_picked = 0

var ball_select_sound_player

## LOTTO BALL GENERATOR:
## - Main purpose: orchestrates the overall logic of the Lotto Generator
## - Randomizes the order of the lotto balls inside the machine
## - Randomly selects a lotto ball, removes it from the group and releases
##   it as a single ball with physics applied
## - Activates the Lotto Ball Icon Layer after each selection
## - Selects only 7 balls: after that, the player must go back to main menu
## - Activates the lotto ball selection only when the Pick a Ball button is pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	
	lotto_ball_rows = get_node("lotto_balls").get_children()
	lotto_points_icons = get_node("lotto_points_layer").point_icons
	
	for lbr in lotto_ball_rows:
		for lb in lotto_ball_rows[lbr.get_index()].get_children():
			if !lb.selected:
				lotto_balls.append(lb)

	var index = 0
	for lb in lotto_balls:
		lb.show_ball_number(numbers[index])
		index = index + 1
	
	balls_left_label = get_node("Balls left")
	picking_a_ball_label = get_node("Picking a Ball")
	
	ball_select_sound_player = get_node("BallSelectSound")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	balls_left_label.text = "Balls Picked: " + str(balls_picked) + "/7"
	
	for lbr in lotto_ball_rows:	
		for lb in lbr.get_children():
			if lb.selected == true:
				lbr.remove_child(lb)
				lb.transform.origin = get_node("ReleasePoint").transform.origin
				get_node("ReleasePoint").add_child(lb)
				
		if lbr.get_index() % 2 == 2 || lbr.get_index() % 2 == 0:
			lbr.rotate(Vector3(0, -1.0, 0), 0.3)
		else:
			lbr.rotate(Vector3(0, 1.0, 0), 0.3)
	
func _input(_event):
	if pick_button_is_pressed && lotto_turns > 0:
		press_count = press_count + 1
		if lotto_ball_rows.size() > 0:
			var random_number_1 = randi() % lotto_ball_rows.size()
			if lotto_ball_rows[random_number_1].get_children().size() > 0 && press_count == 1:
				var random_number_2 = randi() % lotto_ball_rows[random_number_1].get_children().size()
				var selected_ball = lotto_ball_rows[random_number_1].get_child(random_number_2)
				selected_ball.selected = true
				picking_a_ball_label.text = "Picking a Ball..."
				ball_select_sound_player.playing = true 
				var score_icon_index = (7 - (lotto_turns))
				balls_picked = balls_picked + 1
				lotto_points_icons[score_icon_index].get_child(1).text = str(selected_ball.ball_number)
				lotto_turns = lotto_turns - 1
				await get_tree().create_timer(4).timeout
				lotto_points_icons[score_icon_index].is_selected = true					
				press_count = 0
				picking_a_ball_label.text = ""
				
func _on_press_to_pick_button_down():
	pick_button_is_pressed = true
	
func _on_press_to_pick_button_up():
	pick_button_is_pressed = false

func _on_exit_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
