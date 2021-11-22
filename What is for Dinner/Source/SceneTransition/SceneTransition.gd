extends ColorRect

# Path to the next scene to transition to
var next_scene_path: String

# Reference to the _AnimationPlayer_ node
onready var _anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	# Plays the animation backward to fade in
	_anim_player.play_backwards("Fade")


func transition_to(_next_scene: String = next_scene_path) -> void:
	show()
	
	# Plays the Fade animation and wait until it finishes
	_anim_player.play("Fade")
	yield(_anim_player, "animation_finished")
	# Changes the scene
	var err = get_tree().change_scene(_next_scene)
	assert(err == OK, 
			"Error with changing scenes to: %s. Code: %d" % [_next_scene, err])
