extends Node2D

var podiums = []

signal selected

# Called when the node enters the scene tree for the first time.
func _ready():
	podiums.append(get_parent().elemOrder.pop_front())
	podiums.append(get_parent().elemOrder.pop_front())
	
	# Dynamically set podium sprite textures based on what is generated from tutorial
	# Sprite will be found in "res://Assets/ElemSprites/[# generated based on elem]"
	$Podium1/Sprite.region_rect = Rect2(podiums[0] * 64, 0, 64, 64)
	$Podium2/Sprite.region_rect = Rect2(podiums[1] * 64, 0, 64, 64)

func select_option(body):
	var modspell = spellone
	var podium = 0
	if body.global_position.x <= $Podium1.global_position.x + 200 and body.global_position.x >= $Podium1.global_position.x - 300:
		# Podium 1 Selected
		podium = 0
		print("Podium 1: " + str(podiums[0]))
	elif body.global_position.x <= $Podium2.global_position.x + 200 and body.global_position.x >= $Podium2.global_position.x - 300:
		# Podium 2 Selected
		podium = 1
		print("Podium 2: " + str(podiums[1]))
	
	if modspell.active:
		modspell = spelltwo
	modspell.active = true
	modspell.element = podiums[podium]
	
	emit_signal("selected")
	
	# Once something is selected, free the podium so only one can be selected
	queue_free()

