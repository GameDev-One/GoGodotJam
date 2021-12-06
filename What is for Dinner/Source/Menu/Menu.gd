extends Control

onready var SceneTransition: ColorRect = $SceneTransition
onready var Options: Control = $Options


func _on_ContinueBtn_pressed():
	GlobalSignals.emit_signal("GamePaused", false)
	hide()


func _on_OptionBtn_pressed():
	Options.show()


func _on_MenuBtn_pressed():
	GlobalSignals.emit_signal("GamePaused", true)
	show()


func _on_RestartBtn_pressed():
	SceneTransition.transition_to("res://Source/Main.tscn")
