extends "res://Scripts/UI_spellbar.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	# This is a brute force fix. Try something better
	setObj(spelltwo)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
