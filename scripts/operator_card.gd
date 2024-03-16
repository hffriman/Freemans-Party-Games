extends Control

var selected = false
var clickCount = 0
@onready var animation = $AnimationPlayer


var flip1_has_played = false
var flip2_has_played = false

var card_sound_played = false
var card_sound_player

## OPERATOR CARD:
## - Main purpose: it is used in the final part of the Dice Game
## - Whenever it is selected, it will activate a flip animation (with sound effects) 
##   and then shows its inner value (+, -, *, / or ^)
## - The value of the card will determine the overall result of the dice game

# Called when the node enters the scene tree for the first time.
func _ready():
	card_sound_player = get_node("CardSoundPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if selected and !flip1_has_played:
		self.get_child(0).visible = true
		animation.play("flip_1")
		if not card_sound_played:
			card_sound_player.play()
			card_sound_played = true
		
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
