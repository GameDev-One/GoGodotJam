extends Control

const FILE_PATH = "user://Resources/RestaurantItems"

var List : Array = Array()

onready var RestaurantName: OptionButton = $Btns/VBoxContainer/RestaurantName
onready var NewRestaurantPrompt: PopupPanel = $Btns/VBoxContainer/RestaurantName/PopupPanel
onready var CuisineBtn: OptionButton = $Btns/VBoxContainer/GridContainer/CuisineBtn
onready var RatingBtn: OptionButton = $Btns/VBoxContainer/GridContainer/RatingBtn
onready var SeatingBtn: OptionButton = $Btns/VBoxContainer/GridContainer/SeatingBtn
onready var PriceBtn: OptionButton = $Btns/VBoxContainer/GridContainer/PriceBtn
onready var Anim: AnimationPlayer = $AnimationPlayer



func _ready():
	Initialize_List()
	
	# Update UI
	Update_List()
	
	Select_Restaurant(0)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		Save_List()
	elif what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		Save_List()
	elif what == NOTIFICATION_EXIT_TREE:
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


func _Clear_Directory(path):
	# Open existing Directory
	var dir = Directory.new()
	dir.open(path)
	
	# Delete each file in the directory
	dir.list_dir_begin(true)
	var file = dir.get_next()
	while file != '':
		dir.remove(file)
		file = dir.get_next()
	

func _get_files(path):
	# Open new Directory
	var files = []
	var dir = Directory.new()
	var err = dir.open(path)
	
	# If open failed, create new directory
	if err:
		# Create new directory
		var fldrerr = dir.make_dir_recursive(path)
		assert(fldrerr == OK, "Failed to create filepath: %s" % path)
		
		# 2nd attempt to open
		fldrerr = dir.open(path)
		assert(fldrerr == OK, "Failed to get files from: %s" % path)
	
	# Read in the names of each file
	dir.list_dir_begin(true)
	var file = dir.get_next()
	while file != '':
		files += [path + '/' + file]
		file = dir.get_next()
	
	# Return array of file names
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
	
	# Create default list if none exists
	if files.empty():
		var default_item: Restaurant_Item = Restaurant_Item.new()
		default_item.Name = "McDonalds"
		default_item.Cuisine = Restaurant_Item.CuisineEnum.American
		default_item.Rating = Restaurant_Item.RatingEnum.One_Star
		default_item.Seating = Restaurant_Item.SeatingEnum.Takeout
		default_item.Price = Restaurant_Item.PriceEnum.One_Dollar_Sign
		List.append(default_item)
		Save_List()
		
	# Otherwise load List from files
	else:
		for i in range(files.size()):
			var resource: Restaurant_Item = Restaurant_Item.load_from_file(files[i])
			if resource is Restaurant_Item:
				List.append(resource)
				
	# List has been initialized
	GlobalSignals.emit_signal("ListIntialized", List)


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
	if List.empty():
		return
	if index == RestaurantName.get_item_count() - 1:
		NewRestaurantPrompt.popup_centered()
	else:
		RestaurantName.select(index)
		CuisineBtn.select(List[index].Cuisine)
		RatingBtn.select(List[index].Rating)
		SeatingBtn.select(List[index].Seating)
		PriceBtn.select(List[index].Price)


func Save_List():
	_Clear_Directory(FILE_PATH)
	
	for item in List:
		var err = Restaurant_Item.save_to_file(FILE_PATH + "/", item)
		assert(err == OK, "Failed to save file! File Name: " + item.Name)


func Add_Restaurant(restaurant_name: String):
	var new_item: Restaurant_Item = Restaurant_Item.new()
	new_item.Name = restaurant_name
	List.append(new_item)
