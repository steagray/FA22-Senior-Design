extends Node2D


# Declare member variables here. Examples:
const camera = true

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.canMove = false
	yield(get_tree().create_timer(0.5), "timeout")
	stats.canMove = true

func _on_camTransfer():
	$KinematicPlayer2D.global_position = stats.owpos
	$PlayerCam.global_position = stats.campos


func _on_trap1(body):
	for i in range(-22, -1):
		for j in range(-16, -3):
			$TileMap.set_cell(i, j, 1)


func _on_Secret1_body_entered(body):	
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Secret1/Position2D.global_position
		get_tree().change_scene("res://Scenes/Off-Shoots/Enemy Test Scene.tscn")


func _on_Tower_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Tower/Position2D.global_position
		get_tree().change_scene("res://Scenes/Underworld.tscn")


func _on_Secret2_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Secret2/Position2D.global_position
		get_tree().change_scene("res://Scenes/Off-Shoots/fiftyfifty.tscn")


func _on_Secret3_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Secret3/Position2D.global_position
		get_tree().change_scene("res://Scenes/Off-Shoots/Mini-Dungeon Four.tscn")


func _on_Secret4_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Secret4/Position2D.global_position
		get_tree().change_scene("res://Scenes/Off-Shoots/Mini-Dungeon Three.tscn")


func _on_Secret5_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Secret5/Position2D.global_position
		get_tree().change_scene("res://Scenes/Off-Shoots/Mini-Dungeon Two.tscn")


func _on_Secret6_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		stats.owpos = $OverworldZones/Secret6/Position2D.global_position
		get_tree().change_scene("res://Scenes/Off-Shoots/Min-Dungeon Five.tscn")
