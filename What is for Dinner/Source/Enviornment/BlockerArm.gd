extends CSGBox

onready var Anim: AnimationPlayer = $AnimationPlayer

func _ready():
	randomize()
	
	#Select random direction to turn
	var anim_name = Anim.get_animation_list()[randi() % 3 + 1]
	Anim.play(anim_name)
	
	
