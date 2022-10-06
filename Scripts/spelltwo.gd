extends "res://Scripts/spell.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func castSpell():
	if currCD > 0:
		return
	stats.canMove = false
	# create projectile
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD
