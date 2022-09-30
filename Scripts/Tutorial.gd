extends Node2D


# Declare member variables here. Examples:
var firstElem = false # Checks whether user grabbed the first element yet
var secondElem = false # Checks whether user grabbed the second element yet
var elemOrder = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set up UI
	var UI = load("res://Scenes/UI.tscn").instance()
	self.get_node("KinematicPlayer2D/PlayerCam").add_child(UI)
	
	print(get_node("/root").size)
	UI.rect_size = get_node("/root").size
	
	# Creates a random permutation of the values 1-4 in an array that will define the order elements are offered
	randomize()
	while elemOrder.size() < 4:
		var ele = randi() % 4
		if elemOrder.find(ele) == -1:
			elemOrder.append(ele)
	# spawn 4 items

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
