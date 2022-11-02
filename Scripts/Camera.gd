extends Camera2D

func _camZone_entered(body):	
	var player = get_tree().root.get_node("Node2D/KinematicPlayer2D")
	if body.get_instance_id() != player.get_instance_id():
		return
	
	# Get the closest load zone to the player and move in that direction
	var shortest = player.global_position.distance_to(self.get_children()[0].global_position)
	var shortnode = self.get_children()[0]
	for i in range(1, 4):
		var test = player.global_position.distance_to(self.get_children()[i].global_position)
		if shortest > test:
			shortest = test
			shortnode = get_child(i)
			print(shortnode.name)
	
	match shortnode.name:
		"Left":
			self.position.x -= get_viewport().size.x * self.zoom.x
		"Right":
			self.position.x += get_viewport().size.x * self.zoom.x
		"Up":
			self.position.y -= get_viewport().size.y * self.zoom.y
		"Down":
			self.position.y += get_viewport().size.y * self.zoom.y
	
	# TODO: Add moving in that direction
