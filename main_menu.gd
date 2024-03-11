extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_lotto_generator_pressed():
	get_tree().change_scene_to_file("res://lotto_generator.tscn")
	
func _on_dice_game_pressed():
	get_tree().change_scene_to_file("res://dicegame.tscn")
