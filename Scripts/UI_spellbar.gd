extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spellobj

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	spellobj = null
	
func setObj(obj):
	spellobj = obj
	max_value = spellobj.maxCD

func setBarColor():
	var barcolor
	match spellobj.element:
		spellobj.elem.FIRE:
			barcolor = 5
		spellobj.elem.WATER:
			barcolor = 1
		spellobj.elem.EARTH:
			barcolor = 3
		spellobj.elem.AIR:
			barcolor = 2
	texture_progress = load("res://Assets/UI/PNG/Progress0" + str(barcolor) + ".png")

func _process(delta):
	if spellobj != null:
		value = spellobj.currCD
