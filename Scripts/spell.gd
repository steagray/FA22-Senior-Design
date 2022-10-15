extends KinematicBody2D

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element
var maxCD = 5
var currCD = 0
var active = true
var speed = 20
var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	pass
	# var collision_info = move_and_collide(velocity * delta * speed)

func castSpell(vel):
	if currCD > 0:
		return
	stats.canMove = false
	# The bullet was instanced in the player script
	# We just need to tell it where to go
	velocity = vel
	# Remove Projectile
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD
