extends TextureButton

var music_bus = AudioServer.get_bus_index("Music")
@onready var soundsave = $"/root/SoundSave"

## MUSIC BUTTON:
## - Main purpose: turns the Music ON/OFF when this button is pressed in the Main Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	button_pressed = soundsave.music_pressed

func _on_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
	soundsave.music_pressed = not soundsave.music_pressed
