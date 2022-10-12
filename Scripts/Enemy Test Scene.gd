extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1, 4):
		# Deletes all the MeleeTanks. mostly for testing the ranged enemy
		get_node("MeleeTank" + str(i)).queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
