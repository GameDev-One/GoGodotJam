extends Control

var NumOrbsCollected: int = 0

onready var NumOrbsCollectedLabel: Label = $VBoxContainer/Label


func _ready():
	GlobalSignals.connect("OrbCollected", self, "_on_Orb_Collected")

func _on_Orb_Collected(a, b, c, d):
	NumOrbsCollected += 1
	NumOrbsCollectedLabel.text = String(NumOrbsCollected)
