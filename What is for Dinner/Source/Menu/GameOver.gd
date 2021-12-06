extends Control

const MAX_INT = 9223372036854775807

onready var SceneTransition: ColorRect = $SceneTransition

onready var ResultLbl: Label = $CenterContainer/VBoxContainer/Result/Label
onready var OrbsCollectedLbl: Label = $CenterContainer/VBoxContainer/OrbsCollected/Label
onready var CuisineLbl: Label = $CenterContainer/VBoxContainer/CuisineAvg/Label
onready var RatingLbl: Label = $CenterContainer/VBoxContainer/RatingAvg/Label
onready var SeatingLbl : Label = $CenterContainer/VBoxContainer/SeatingAvg/Label
onready var PriceLbl: Label = $CenterContainer/VBoxContainer/PriceAvg/Label
onready var FinalScoreLbl: Label = $CenterContainer/VBoxContainer/FinalScore/Label

var OrbsCollected = 0
var CuisinePtsTtl: float = 0
var RatingPtsTtl: float = 0
var SeatingPtsTtl: float = 0
var PricePtsTtl: float = 0

var CuisinePtsAvg: float = 0
var RatingsPtsAvg: float = 0
var SeatingPtsAvg: float = 0
var PricePtsAvg: float = 0

var List: Array = Array()

 
func _ready():
	GlobalSignals.connect("ListIntialized", self, "_on_List_Initialized")
	GlobalSignals.connect("GameOver", self, "_on_Game_Over")
	GlobalSignals.connect("OrbCollected", self, "_on_Orb_Collected")


func _on_Game_Over():
	UpdateUI()
	SceneTransition.transition_to("")
	show()


func _on_Orb_Collected(cuisine, rating, seating, price):
	OrbsCollected += 1
	CuisinePtsTtl += cuisine
	RatingPtsTtl += rating
	SeatingPtsTtl += seating
	PricePtsTtl += price


func UpdateUI():
	OrbsCollectedLbl.text = "$" + str(OrbsCollected) + ".00"
	
	var final_score = 0
	var format_str = "$" + "%.2f"
	
	#Prevent divide by zero in calculations
	if OrbsCollected == 0:
		OrbsCollected = 1
		
	CuisinePtsAvg = CuisinePtsTtl / OrbsCollected
	CuisineLbl.text = format_str % CuisinePtsAvg
	final_score += CuisinePtsAvg
	
	RatingsPtsAvg = RatingPtsTtl / OrbsCollected
	RatingLbl.text = format_str % RatingsPtsAvg
	final_score *= RatingsPtsAvg
	
	SeatingPtsAvg = SeatingPtsTtl / OrbsCollected
	SeatingLbl.text = format_str % SeatingPtsAvg
	final_score *= SeatingPtsAvg
	
	PricePtsAvg = PricePtsTtl / OrbsCollected
	PriceLbl.text = format_str % PricePtsAvg
	final_score += PricePtsAvg
	
	FinalScoreLbl.text = format_str % final_score
	
	ResultLbl.text = FindClosestRestaurant(CuisinePtsAvg, 
											RatingsPtsAvg, 
											SeatingPtsAvg, 
											PricePtsAvg)


func _on_List_Initialized(list):
	List = list


func FindClosestRestaurant(a, b, c, d) -> String:
	var dist = MAX_INT
	var name = ""
	for item in List:
		var new_dist = pow(item.Cuisine - a, 2) + pow(item.Rating - b, 2) + pow(item.Seating - c, 2) + pow(item.Price - d, 2)
		if new_dist < dist:
			dist = new_dist
			name = item.Name
	return name
