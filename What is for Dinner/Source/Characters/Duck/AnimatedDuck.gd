extends Spatial

enum State {
				IDLE, 
				MOVE
			}
			
onready var Anim: AnimationTree = $AnimationTree
onready var _Playback: AnimationNodeStateMachinePlayback = Anim["parameters/playback"]

var MoveDirection: Vector3 = Vector3.ZERO setget set_move_direction
var is_moving: bool = false setget set_is_moving


func _ready() -> void:
	Anim.active = true

	
func set_move_direction(direction: Vector3) -> void:
	MoveDirection = direction
	Anim["parameters/Move/blend_position"] = direction.length()

func set_is_moving(value: bool):
	is_moving = value


func transition_to(state_id: int) -> void:
	match state_id:
		State.IDLE:
			_Playback.travel("Idle")
		State.MOVE:
			_Playback.travel("Move")
		_:
			_Playback.travel("Idle")
