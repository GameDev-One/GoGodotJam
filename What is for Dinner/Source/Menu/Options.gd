extends Control

const FILE_PATH = "user://"
const FILE_NAME = "options.cfg"

onready var GameDurationOpts: Array = $Btns/VBoxContainer/GameDurationOpt.get_children()
onready var MasterVolumeSlider: HSlider = $Btns/VBoxContainer/MasterVoumeSlider
onready var ConfirmationPanel: ConfirmationDialog = $Btns/VBoxContainer/ListOpt/ClearBtn/Confirmation
onready var ListPanel: Control = $List

var MasterVolume: float = 50 setget set_volume, get_volume
var GameDuration: int = 15


func _enter_tree():
	# Load config from ini file
	var err = Load()
	if err:
		# Create new config file with default settings
		Save()


func _ready():
	SetGameDurationBtnSelected()


func _exit_tree():
	Save()


func Save():
	var config = ConfigFile.new()
	config.set_value("Options", "Game Duration", GameDuration)
	config.set_value("Options", "Master Volume", MasterVolume)
	
	# Save it to a file (overwrite if already exists).
	config.save(FILE_PATH + FILE_NAME)


func Load() -> int:
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load(FILE_PATH + FILE_NAME)

	# If the file didn't load, ignore it.
	if err != OK:
		return ERR_FILE_CANT_OPEN
		
	MasterVolume = config.get_value("Options", "Master Volume")
	GameDuration = config.get_value("Options", "Game Duration")
	
	return OK


func set_volume(val: float):
	MasterVolumeSlider.value = val


func get_volume() -> float:
	return MasterVolumeSlider.value


func SetGameDurationBtnSelected():
	match GameDuration:
		15:
			_on_Opt1_toggled(true)
		30:
			_on_Opt2_toggled(true)
		60:
			_on_Opt3_toggled(true)
		120:
			_on_Opt4_toggled(true)
		_:
			assert(GameDuration, "Incorrect Game Duration has been selected")


func _on_Opt1_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = true
		GameDurationOpts[1].pressed = false
		GameDurationOpts[2].pressed = false
		GameDurationOpts[3].pressed = false
		GameDuration = 15


func _on_Opt2_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = false
		GameDurationOpts[1].pressed = true
		GameDurationOpts[2].pressed = false
		GameDurationOpts[3].pressed = false
		GameDuration = 30


func _on_Opt3_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = false
		GameDurationOpts[1].pressed = false
		GameDurationOpts[2].pressed = true
		GameDurationOpts[3].pressed = false
		GameDuration = 60


func _on_Opt4_toggled(button_pressed):
	if button_pressed:
		GameDurationOpts[0].pressed = false
		GameDurationOpts[1].pressed = false
		GameDurationOpts[2].pressed = false
		GameDurationOpts[3].pressed = true
		GameDuration = 120


func _on_BackBtn_pressed():
	hide()


func _on_EditBtn_pressed():
	ListPanel.show()


func _on_ClearBtn_pressed():
	ConfirmationPanel.popup_centered(ConfirmationPanel.rect_min_size)


func _on_Confirmation_confirmed():
	ListPanel.Clear()
	ListPanel.Save_List()
