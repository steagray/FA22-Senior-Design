extends Node

var fire_proj = load("res://Scenes/Fire_Projectile.tscn")

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element
var maxCD = 5
var currCD = 0
var active = true
var speed = 20

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
	# Make Projectile
	var proj_instance = fire_proj.instance()
	add_child(proj_instance)
	#proj_instance.global_position = spellOrigin.global_postion
	# Remove Projectile
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD
