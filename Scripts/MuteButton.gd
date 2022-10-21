extends CheckBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _toggled(button_pressed):
	get_tree().root.get_node("Node2D/BGM").playing = not get_tree().root.get_node("Node2D/BGM").playing
