extends TextureButton

var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var soundsave = $"/root/SoundSave"

## SOUND BUTTON
## - Purpose: turns the SFX ON/OFF whenever this button is pressed in the Main Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	button_pressed = soundsave.sfx_pressed


func _on_pressed():
	AudioServer.set_bus_mute(sfx_bus, not AudioServer.is_bus_mute(sfx_bus))
	soundsave.sfx_pressed = not soundsave.sfx_pressed
