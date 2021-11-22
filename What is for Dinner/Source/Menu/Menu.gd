extends Control

onready var SceneTransition: ColorRect = $SceneTransition
onready var Options: Control = $Options


func _on_ContinueBtn_pressed():
	hide()


func _on_OptionBtn_pressed():
	Options.show()


func _on_MenuBtn_pressed():
	show()


func _on_RestartBtn_pressed():
	SceneTransition.transition_to("res://Source/Main.tscn")
