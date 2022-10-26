extends Camera2D

func _camZone_entered(body):	
	var player = get_tree().root.get_node("Node2D/KinematicPlayer2D")
	if body.get_instance_id() != player.get_instance_id():
		return
	
	# Get the closest load zone to the player and move in that direction
	var shortest = player.position.distance_to(self.get_children()[0].position)
	for i in range(1, 4):
		var test = player.position.distance_to(self.get_children()[i].position)
		if shortest > test:
			shortest = test
	
	print(shortest)
	# TODO: Add moving in that direction
