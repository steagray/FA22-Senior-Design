extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _new_game():
	$NewGame.flip_v = not $NewGame.flip_v
	# Transition
	get_tree().change_scene("res://Scenes/Tutorial.tscn")


func _quit():
	get_tree().quit()
