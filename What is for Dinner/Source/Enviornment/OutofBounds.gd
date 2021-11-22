extends Area
export var StartPosition = Vector3.ZERO

func _on_OutofBounds_body_entered(body):
	if body is KinematicBody:
		body.transform.origin = StartPosition
