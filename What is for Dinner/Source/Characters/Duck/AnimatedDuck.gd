extends Spatial

onready var Anim: AnimationPlayer

func Play(name: String):
	Anim.play(name)
