extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Health: " + str(stats.health) + "\n"
	text += "Spell 1: " + str(spellone.currCD) + "\n"
	text += "Spell 2: " + str(spelltwo.currCD)
