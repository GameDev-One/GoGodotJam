extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if Player.is_on_floor() or Player.is_on_wall():
		if _parent.Velocity.length() < 0.001:
			_state_machine.transition_to("Move/Idle")
		

func enter(msg: = {}) -> void:
	Model.transition_to(Model.State.MOVE)
	Model.is_moving = true
	_parent.enter()


func exit() -> void:
	Model.is_moving = false
	_parent.exit()
