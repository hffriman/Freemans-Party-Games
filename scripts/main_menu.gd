extends Node3D

## MAIN MENU
## - Main purpose: contains the buttons for Lotto Generator, Dice Game and Credits

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_lotto_generator_pressed():
	get_tree().change_scene_to_file("res://scenes/lotto_generator.tscn")
	
func _on_dice_game_pressed():
	get_tree().change_scene_to_file("res://scenes/dicegame.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
