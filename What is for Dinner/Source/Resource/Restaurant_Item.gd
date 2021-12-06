extends Resource
class_name Restaurant_Item

enum CuisineEnum{
	None,
	American,
	Chinese,
	Cuban,
	French,
	Greek,
	Indian,
	Italian,
	Japanese,
	Korean,
	Malaysian,
	Mexican
	Spanish,
	Thai,
	Vietnamese
}

enum RatingEnum{
	No_Stars,
	One_Star,
	Two_Stars,
	Three_Stars,
	Four_Stars,
	Five_Stars
}

enum SeatingEnum{
	None,
	Indoor,
	Outdoor,
	Takeout,
	All
}

enum PriceEnum{
	No_Dollar_Sign
	One_Dollar_Sign,
	Two_Dollar_Signs,
	Three_Dollar_Signs,
	Four_Dollar_Signs,
	Five_Dollar_Signs
}

export var Name: String = ""
export var Cuisine: int = CuisineEnum.None
export var Rating: int = RatingEnum.No_Stars
export var Seating: int = SeatingEnum.None
export var Price: int = PriceEnum.No_Dollar_Sign


static func load_from_file(file_path: String) -> Restaurant_Item:
	var res
	if file_path.ends_with(".tres"):
		res = ResourceLoader.load(file_path)
	return res
	
static func save_to_file(file_path: String, resource: Restaurant_Item) -> int:
	return ResourceSaver.save(file_path + resource.Name + ".tres", resource)
