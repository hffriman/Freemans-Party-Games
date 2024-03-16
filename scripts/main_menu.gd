extends Node3D

var loading_dice_game_layer
var loading_lotto_generator_layer

## MAIN MENU
## - Main purpose: contains the buttons for Lotto Generator, Dice Game and Credits
## - Shows "Loading" layers before the scene changes to either Lotto Generator or Dice Game

# Called when the node enters the scene tree for the first time.
func _ready():
	loading_dice_game_layer = get_node("LoadingDiceGameLayer")
	loading_lotto_generator_layer = get_node("LoadingLottoGeneratorLayer")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_lotto_generator_pressed():
	loading_lotto_generator_layer.visible = true
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/lotto_generator.tscn")
	
func _on_dice_game_pressed():
	loading_dice_game_layer.visible = true
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/dicegame.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
