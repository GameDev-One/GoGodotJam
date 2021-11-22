extends Control

var List : Array = Array()

onready var RestaurantName: OptionButton = $Btns/VBoxContainer/RestaurantName
onready var CuisineBtn: OptionButton = $Btns/VBoxContainer/GridContainer/CuisineBtn
onready var RatingBtn: OptionButton = $Btns/VBoxContainer/GridContainer/RatingBtn
onready var SeatingBtn: OptionButton = $Btns/VBoxContainer/GridContainer/SeatingBtn
onready var PriceBtn: OptionButton = $Btns/VBoxContainer/GridContainer/PriceBtn


func _ready():
	
	var files = get_files("user://")
	print(files)
	
	for file in files:
		RestaurantName.add_item(file.get_basename(), RestaurantName.get_item_count())

func _on_BackBtn_pressed():
	hide()


func _on_RestaurantName_item_selected(index):
	if index == 0:
		pass
	else:
		CuisineBtn.select(List[index - 1].Cuisine)
		RatingBtn.select(List[index - 1].Rating)
		SeatingBtn.select(List[index - 1].Seating)
		PriceBtn.select(List[index - 1].Price)


func _on_CuisineBtn_item_selected(index):
	if RestaurantName.selected > 0 and index > 0:
		List[RestaurantName.selected - 1].Cuisine = index
		var err = ResourceSaver.save("user://" + List[RestaurantName.selected - 1].resource_path.get_file(), List[RestaurantName.selected - 1])
		assert(err == OK, "Failed to save file! File Name: " + List[RestaurantName.selected - 1].resource_path.get_file())

func _on_RatingBtn_item_selected(index):
	if RestaurantName.selected > 0 and index > 0:
		List[RestaurantName.selected - 1].Rating = index
		var err = ResourceSaver.save("user://" + List[RestaurantName.selected - 1].resource_path.get_file(), List[RestaurantName.selected - 1])
		assert(err == OK, "Failed to save file! File Name: " + List[RestaurantName.selected - 1].resource_path.get_file())


func _on_SeatingBtn_item_selected(index):
	if RestaurantName.selected > 0 and index > 0:
		List[RestaurantName.selected - 1].Seating = index
		var err = ResourceSaver.save("user://" + List[RestaurantName.selected - 1].resource_path.get_file(), List[RestaurantName.selected - 1])
		assert(err == OK, "Failed to save file! File Name: " + List[RestaurantName.selected - 1].resource_path.get_file())


func _on_PriceBtn_item_selected(index):
	if RestaurantName.selected > 0 and index > 0:
		List[RestaurantName.selected - 1].Price = index
		var err = ResourceSaver.save("user://" + List[RestaurantName.selected - 1].resource_path.get_file(), List[RestaurantName.selected - 1])
		assert(err == OK, "Failed to save file! File Name: " + List[RestaurantName.selected - 1].resource_path.get_file())


func get_files(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)
	
	var file = dir.get_next()
	while file != '':
		files += [file]
		file = dir.get_next()
		
	return files
