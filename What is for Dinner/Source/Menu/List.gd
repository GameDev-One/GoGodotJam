extends Control

const FILE_PATH = "user://"

var List : Array = Array()

onready var RestaurantName: OptionButton = $Btns/VBoxContainer/RestaurantName
onready var NewRestaurantPrompt: PopupPanel = $Btns/VBoxContainer/RestaurantName/PopupPanel
onready var CuisineBtn: OptionButton = $Btns/VBoxContainer/GridContainer/CuisineBtn
onready var RatingBtn: OptionButton = $Btns/VBoxContainer/GridContainer/RatingBtn
onready var SeatingBtn: OptionButton = $Btns/VBoxContainer/GridContainer/SeatingBtn
onready var PriceBtn: OptionButton = $Btns/VBoxContainer/GridContainer/PriceBtn

onready var Anim: AnimationPlayer = $AnimationPlayer

func _ready():
	# Load files into List
	Initialize_List()
	
	# Update UI
	Update_List()
	
	Select_Restaurant(0)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		Save_List()
	elif what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		Save_List()


func _on_BackBtn_pressed():
	hide()


func _on_RestaurantName_item_selected(index):
	Select_Restaurant(index)


func _on_CuisineBtn_item_selected(index):
	Anim.play("cuisine_btn_flash")
	List[RestaurantName.selected].Cuisine = index
	

func _on_RatingBtn_item_selected(index):
	List[RestaurantName.selected].Rating = index
	Anim.play("rating_btn_flash")


func _on_SeatingBtn_item_selected(index):
	List[RestaurantName.selected].Seating = index
	Anim.play("seating_btn_flash")


func _on_PriceBtn_item_selected(index):
	List[RestaurantName.selected].Price = index
	Anim.play("price_btn_flash")


func _get_files(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)
	
	var file = dir.get_next()
	while file != '':
		files += [path + file]
		file = dir.get_next()
		
	return  files


func _on_LineEdit_text_entered(new_text):
	Add_Restaurant(new_text)
	Update_List()
	Select_Restaurant(List.size() - 1)
	NewRestaurantPrompt.hide()
	Anim.play("new_item_added_flash")


func Initialize_List():
	# Read each file into List if is Restaurant_Item
	var files = _get_files(FILE_PATH)
	for i in range(files.size()-1, -1, -1):
		var resource: Restaurant_Item = Restaurant_Item.load_from_file(files[i])
		if resource:
			List.append(resource)


func Clear():
	List.clear()
	Update_List()


func Update_List():
	# Update UI
	RestaurantName.clear()
	for item in List:
		RestaurantName.add_item(item.Name, RestaurantName.get_item_count())
	RestaurantName.add_item("Add Item (+)", RestaurantName.get_item_count())


func Reset_Buttons():
	CuisineBtn.select(List[0].Cuisine)
	RatingBtn.select(List[0].Rating)
	SeatingBtn.select(List[0].Seating)
	PriceBtn.select(List[0].Price)


func Select_Restaurant(index: int):
	if index == RestaurantName.get_item_count() - 1:
		NewRestaurantPrompt.popup_centered()
	else:
		RestaurantName.select(index)
		CuisineBtn.select(List[index].Cuisine)
		RatingBtn.select(List[index].Rating)
		SeatingBtn.select(List[index].Seating)
		PriceBtn.select(List[index].Price)


func Save_List():
	for item in List:
		var err = Restaurant_Item.save_to_file(FILE_PATH, item)
		assert(err == OK, "Failed to save file! File Name: " + item.Name)
	pass


func Add_Restaurant(restaurant_name: String):
	var new_item: Restaurant_Item = Restaurant_Item.new()
	new_item.Name = restaurant_name
	List.append(new_item)
