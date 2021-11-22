extends Area

func _on_FoodThoughtOrbs_body_entered(body):
	if body is KinematicBody:
		queue_free()
