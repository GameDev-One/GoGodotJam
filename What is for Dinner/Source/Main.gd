extends Node

onready var joystick: Node = $UI/VirtualJoystick

onready var MenuBtn: Button = $UI/MenuBtn
onready var TimeLeft: Control = $UI/TimeLeft
onready var OrbsCollected: Control = $UI/OrbsCollected

onready var CutScene: Control = $Cutscene/UI/Tutorial

func _ready():
	joystick.use_input_actions = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Cutscene":
		MenuBtn.show()
		
		TimeLeft.show()
		TimeLeft.Start()
		
		OrbsCollected.show()
		
		joystick.show()
		joystick.use_input_actions = true
		
		CutScene.hide()
		
		
