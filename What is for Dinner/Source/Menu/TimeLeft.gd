extends Control

const FILE_PATH = "user://"
const FILE_NAME = "options.cfg"

onready var TimeLeftLabel: Label = $VBoxContainer/Label
onready var Time: Timer = $Timer

func _ready():
	
	GlobalSignals.connect("GamePaused", self, "_on_Game_Paused")
	
	Load()


func Start():
	Time.start()
	

func _process(delta):
	TimeLeftLabel.text = String(stepify(Time.time_left, 0.1))


func Load() -> int:
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load(FILE_PATH + FILE_NAME)

	# If the file didn't load, ignore it.
	if err != OK:
		return ERR_FILE_CANT_OPEN
		
	Time.wait_time = config.get_value("Options", "Game Duration")
	
	return OK


func _on_Game_Paused(is_paused):
		Time.paused = is_paused


func _on_Timer_timeout():
	GlobalSignals.emit_signal("GameOver")
