extends PlayerState

export var MaxSpeed: float = 12.0
export var Speed: float = 10.0
export var Gravity: float = -9.8
export var JumpImpulse: float = 25
export var RotationSpeed: float = 10.0

var Velocity: Vector3 = Vector3.ZERO
var _Direction: Vector3 = Vector3.ZERO


func physics_process(delta: float) -> void:
	# Find direction based on player input
	_Direction = GetInputDirection()
	Model.MoveDirection = _Direction
	_Direction = _Direction.normalized()
	
	
	# Calculate rotation
	if _Direction:
		Model.rotation.y = lerp_angle(Model.rotation.y, atan2(_Direction.x, _Direction.z), RotationSpeed * delta)
		
	# Move the player
	Velocity = CalculateVelocity(Velocity, _Direction, delta)
	Velocity = Player.move_and_slide(Velocity, Vector3.UP)


func CalculateVelocity(Velocity: Vector3, Direction: Vector3, Delta: float) -> Vector3:
	var VelocityNew = Direction * Speed
	if VelocityNew.length() > MaxSpeed:
		VelocityNew = VelocityNew.normalized() * MaxSpeed
	VelocityNew.y = Velocity.y + Gravity * Delta
	return VelocityNew


static func GetInputDirection() -> Vector3:
	return Vector3(
			Input.get_axis("move_left", "move_right"),
			0,
			Input.get_axis("move_forward","move_backward")
		)
