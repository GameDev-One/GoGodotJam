extends Area

onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Audio: AudioStreamPlayer = $AudioStreamPlayer

var cuisine: int = 0
var rating: int = 0
var seating: int = 0
var price: int = 0

func _ready():
	randomize()
	
	cuisine = randi() % 15 + 1
	rating = randi() % 5 + 1
	seating = randi() % 4 + 1
	price = randi() % 5 + 1
	
	Anim.advance(randf())
	

func _on_FoodThoughtOrbs_body_entered(body):
	if body is KinematicBody:
		GlobalSignals.emit_signal("OrbCollected", cuisine, rating, seating, price)
		Audio.play()
		Anim.play("FadeOut")
		yield(Audio, "finished")
		queue_free()
