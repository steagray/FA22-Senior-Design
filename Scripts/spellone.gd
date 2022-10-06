extends "res://Scripts/spell.gd"

export (int) var speed = 20

var direction := Vector2.ZERO

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
	
	# projectile deletion
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD
