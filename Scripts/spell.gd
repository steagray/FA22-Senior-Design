extends Area2D

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element
var maxCD = 4
var currCD = 0
var active = true
var speed = 700
var projLoader

func _body_entered(body):
	if body.has_method("takedmg"):
		body.takedmg()
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	projLoader = load("res://Scenes/Fire_Projectile.tscn")

func changeProj(proj):
	projLoader = load("res://Scenes/" + proj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_local_y(delta * (-speed))

func changeSpeed(spd):
	speed = spd

func castSpell(caster):
	if currCD > 0:
		return
	currCD = maxCD
	
	# Create an instance
	var projectile = projLoader.instance()
	
	# Add to the root tree
	get_parent().add_child(projectile)
	
	# Put the projectile at a global position
	# So it doesn't follow the player
	projectile.position = caster.get_node("SpellOrigin").global_position
	projectile.rotation = caster.get_node("SpellOrigin").global_rotation
	
	# We want to prepare velocity for shooting
	# AKA what direction is this going
		
	stats.canMove = false
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true


