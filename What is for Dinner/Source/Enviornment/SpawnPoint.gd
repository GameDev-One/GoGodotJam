extends Spatial

#Array of Spawnable Objects
const SPAWNABLES = [
	preload("res://Source/Orbs/FoodThoughtOrbs.tscn"),
	]


func _ready():
	randomize()
	SpawnObject()
	
func SpawnObject():
	var instance = SPAWNABLES[randi() % SPAWNABLES.size()].instance()
	add_child(instance)
