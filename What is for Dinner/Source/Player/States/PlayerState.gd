extends State
class_name PlayerState


var Player: Player
var Model: Spatial 


func _ready() -> void:
	yield(owner, "ready")
	Player = owner
	Model = owner.Model
