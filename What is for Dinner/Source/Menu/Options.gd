extends Control

onready var GameDurationOpts: Array = $Btns/VBoxContainer/GameDurationOpt.get_children()
onready var MasterVolumeSlider: HSlider = $Btns/VBoxContainer/MasterVoumeSlider

var MasterVolume: float = 50 setget set_volume, get_volume
var GameDuration: float = 15


func set_volume(val: float):
	MasterVolumeSlider.value = val


func get_volume() -> float:
	return MasterVolumeSlider.value

func _on_Opt1_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[1].pressed = false
		GameDurationOpts[2].pressed = false
		GameDurationOpts[3].pressed = false
		GameDuration = 15


func _on_Opt2_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = false
		GameDurationOpts[2].pressed = false
		GameDurationOpts[3].pressed = false
		GameDuration = 30


func _on_Opt3_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = false
		GameDurationOpts[1].pressed = false
		GameDurationOpts[3].pressed = false
		GameDuration = 60


func _on_Opt4_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = false
		GameDurationOpts[1].pressed = false
		GameDurationOpts[2].pressed = false
		GameDuration = 120
