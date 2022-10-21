extends Node2D


var optionA
var optionB

# Called when the node enters the scene tree for the first time.
func _ready():
	setOP("Podium1", get_parent().elemOrder.pop_front())
	setOP("Podium2", get_parent().elemOrder.pop_front())

func select_option(body):
	if body.global_position.x <= $Podium1.global_position.x + 200 and body.global_position.x >= $Podium1.global_position.x - 300:
		# Podium 1 Selected
		print("Podium 1")
	elif body.global_position.x <= $Podium2.global_position.x + 200 and body.global_position.x >= $Podium2.global_position.x - 300:
		# Podium 2 Selected
		print("Podium 2")
	
	# Once something is selected, free the podium so only one can be selected
	queue_free()

func setOP(option, element):
	match element:
		0:
			# Set fire podium
			print("Hello")
		1:
			# Set water podium
			print("Hello")
		2:
			# Set earth podium
			print("Hello")
		3:
			# Set air podium
			print("Hello")

