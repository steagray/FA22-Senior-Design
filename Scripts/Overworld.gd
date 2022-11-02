extends Node2D


# Declare member variables here. Examples:
const camera = true

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.canMove = false
	yield(get_tree().create_timer(0.5), "timeout")
	stats.canMove = true



func _on_camTransfer():
	$PlayerCam.global_position = $KinematicPlayer2D.global_position


func _on_trap1(body):
	for i in range(-22, -1):
		for j in range(-16, -3):
			$TileMap.set_cell(i, j, 1)
