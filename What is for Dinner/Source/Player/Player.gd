extends KinematicBody

export var Speed: float = 10.0
export var Acceleration: float = 5.0
export var Gravity: float = -9.8
export var JumpPower: float = 20

var _Direction: Vector3 = Vector3.ZERO 
var _Velocity: Vector3 = Vector3.ZERO
var _CaptCrunch: Vector3 = Vector3.ZERO

onready var MeshBody: MeshInstance = $Mesh


func _physics_process(delta):
	
	_Direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		_Direction -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		_Direction += transform.basis.z
		
	if Input.is_action_pressed("move_right"):
		_Direction += transform.basis.x
	elif Input.is_action_pressed("move_left"):
		_Direction -= transform.basis.x
		
	# Jump for 3rd Person from Garbaj
	# https://www.youtube.com/watch?v=MjLuzOzZlmk
	if not is_on_floor():
		_CaptCrunch += Vector3(0, Gravity * delta, 0)
	if Input.is_action_just_pressed("jump"):
		_CaptCrunch = Vector3(0, JumpPower, 0)
	move_and_slide(_CaptCrunch, Vector3.UP)
		
	_Direction = _Direction.normalized()
	_Velocity = _Direction * Speed
	
	# Turn 3rd person character from Tato64 on Godot Forums
	# https://godotengine.org/qa/67967/make-3d-character-face-direction-of-movement
	if _Velocity != Vector3.ZERO:
		var lookdir = atan2(-_Velocity.x, -_Velocity.z)
		MeshBody.rotation.y = lerp(MeshBody.rotation.y, lookdir, 0.1)
	
	_Velocity.linear_interpolate(_Velocity, Acceleration * delta)
	move_and_slide(_Velocity, Vector3.UP)


func rotateAround(obj, point, axis, angle):
	var rot = angle + obj.rotation.y 
	var tStart = point
	obj.global_translate (-tStart)
	obj.transform = obj.transform.rotated(axis, -rot)
	obj.global_translate (tStart)
