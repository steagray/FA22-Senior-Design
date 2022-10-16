extends Area2D

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element
var maxCD = 5
var currCD = 0
var active = true
var speed = 300
var projLoader


# Called when the node enters the scene tree for the first time.
func _ready():
	projLoader = load("res://Scenes/Fire_Projectile.tscn")

func changeProj(proj):
	projLoader = load("res://Scenes/" + proj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_local_y(delta * (-speed))

func castSpell(caster):
	if currCD > 0:
		return
	
	# Create an instance
	var projectile = projLoader.instance()
	
	# Add to the player tree
	get_parent().add_child(projectile)
	
	# Put the projectile at a global position
	# So it doesn't follow the player
	projectile.position = caster.global_position
	projectile.rotation = caster.global_rotation
	
	# We want to prepare velocity for shooting
	# AKA what direction is this going
		
	stats.canMove = false
	# The bullet was instanced in the player script
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD
	
	yield(get_tree().create_timer(3), "timeout")
	projectile.queue_free()
