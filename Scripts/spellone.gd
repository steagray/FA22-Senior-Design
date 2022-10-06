extends "res://Scripts/spell.gd"

export (int) var speed = 20

# Basic Direction the spell will travel
# This will (most likely) be changed for when the spell is cast
var direction := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func castSpell(rotation):
	if currCD > 0:
		return
	stats.canMove = false
	# Projectile calculation
	direction = set_direction(rotation)
	var velocity = direction * speed
	
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD

func set_direction(rotation):
	match rotation:
		0: 
			direction = Vector2.UP
		90:
			direction = Vector2.RIGHT
		180:
			direction = Vector2.DOWN
		270:
			direction = Vector2.LEFT
	return direction
