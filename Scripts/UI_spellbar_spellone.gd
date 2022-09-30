extends "res://Scripts/UI_spellbar.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _enter_tree():
	setObj(spellone)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
