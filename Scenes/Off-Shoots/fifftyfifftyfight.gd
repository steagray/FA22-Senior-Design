extends Area2D

func _ready():
	pass


func _on_Fight_body_entered(body):
	# Load the enemies we want to use
	var enemy_info = load("res://Scenes/MeleeTank1.tscn")
	
	# Creating the number of enemies we want in the background
	var enemy_one = enemy_info.instance()
	var enemy_two = enemy_info.instance()
	
	# Add the enemies to the scene
	get_parent().add_child(enemy_one)
	get_parent().add_child(enemy_two)
	
	#Move them instantly to our spawn point
	enemy_one.global_position = self.get_node("CollisionShape2D/SpawnOne").global_position
	enemy_two.global_position = self.get_node("CollisionShape2D/SpawnTwo").global_position


func _on_Fight_body_exited(body):
	# The makes sure we can't spawn infinite enemies
	queue_free()
