extends ColorRect

# Path to the next scene to transition to
var next_scene_path: String

# Reference to the _AnimationPlayer_ node
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	# Plays the animation backward to fade in
	anim_player.play_backwards("Fade")


func transition_to(_next_scene: String = next_scene_path) -> void:
	show()
	
	# Plays the Fade animation and wait until it finishes
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	
	hide()
	
	if not _next_scene.empty():
		# Changes the scene
		var err = get_tree().change_scene(_next_scene)
		assert(err == OK, 
				"Error with changing scenes to: %s. Code: %d" % [_next_scene, err])
