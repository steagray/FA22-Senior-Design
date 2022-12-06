extends Node2D

func _ready():
	stats.canMove = false
	yield(get_tree().create_timer(0.5), "timeout")
	stats.canMove = true


func _on_Overworld_body_entered(body):
	if body.get_instance_id() == $KinematicPlayer2D.get_instance_id():
		get_tree().change_scene("res://Scenes/Overworld.tscn")
