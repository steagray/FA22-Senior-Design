extends Area2D

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element
var maxCD = 5
var currCD = 0
var active = true
var speed = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	 pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_local_y(delta * (-speed))

func castSpell():
	if currCD > 0:
		return
	stats.canMove = false
	# The bullet was instanced in the player script
	# Remove Projectile
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD
