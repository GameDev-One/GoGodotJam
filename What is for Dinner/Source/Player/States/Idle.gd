extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
	
func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	
	if Player.is_on_floor() and _parent.Velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")


func enter(msg: Dictionary = {}) -> void:
	_parent.Velocity = Vector3.ZERO
	Model.transition_to(Model.State.IDLE)
	_parent.enter()


func exit() -> void:
	_parent.exit()
