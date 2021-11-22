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

export(CuisineEnum) var Cuisine
export(RatingEnum) var Rating
export(SeatingEnum) var Seating
export(PriceEnum) var Price
