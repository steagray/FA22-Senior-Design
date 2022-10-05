extends Node2D


# Declare member variables here. Examples:
var firstElem = false # Checks whether user grabbed the first element yet
var secondElem = false # Checks whether user grabbed the second element yet
var elemOrder = []

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	# Creates a random permutation of the values 1-4 in an array that will define the order elements are offered
	randomize()
	while elemOrder.size() < 4:
		var ele = randi() % 4
		if elemOrder.find(ele) == -1:
			elemOrder.append(ele)
	# spawn 4 items

func _on_OverworldLoad_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		#TODO: stage transition
		get_tree().change_scene("res://Scenes/Overworld.tscn")
		return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

