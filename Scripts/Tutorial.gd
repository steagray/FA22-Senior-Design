extends Node2D


# Declare member variables here. Examples:
var firstElem = false # Checks whether user grabbed the first element yet
var secondElem = false # Checks whether user grabbed the second element yet
var elemOrder = []
var enemiesLeft = 3

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	spellone.active = false
	spelltwo.active = false
	
	for i in range(1,4):
		get_node("MeleeTank" + str(i)).health = 1
		get_node("MeleeTank" + str(i)).speed = 250
		get_node("MeleeTank" + str(i)).setAggro(0)
		if i == 3:
			get_node("MeleeTank" + str(i)).queue_free()
	
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

func _on_EnemyDeath():
	enemiesLeft -= 1
	if enemiesLeft == 0:
		for i in range(68, 71):
			$TileMap.set_cell(i, 11, 1)


func _first_pick():
	for i in range(-4, -1):
		$TileMap.set_cell(38, i, 1)


func _second_pick():
	for i in range(97, 100):
		$TileMap.set_cell(i, 20, 1)
