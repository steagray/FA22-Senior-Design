extends Node
class_name spell

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element = elem.FIRE
var maxCD = 5
var currCD = 0
var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func castSpell():
	if currCD > 0:
		return
	stats.canMove = false
	# create projectile
	
	
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
