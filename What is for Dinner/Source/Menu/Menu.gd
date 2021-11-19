extends Control

onready var SceneTransition: ColorRect = $SceneTransition


func _on_ContinueBtn_pressed():
	SceneTransition.transition_to("res://Source/Main.tscn")
	pass # Replace with function body.


func _on_OptionBtn_pressed():
	SceneTransition.transition_to("res://Source/Menu/Options.tscn")
	pass # Replace with function body.
