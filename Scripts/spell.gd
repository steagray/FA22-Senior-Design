extends Node

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element
var maxCD = 5
var currCD = 0
var active = true
var speed = 20
var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setActive(a):
	self.monitoring = a
	self.monitorable = a
	$Sprite.visible = a

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.global_position += velocity

func castSpell():
	if currCD > 0:
		return
	stats.canMove = false
	currCD = maxCD
	
	# Make Projectile
	setActive(true)
	velocity = Vector2.UP
	
	# Casting Delay
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	
	yield(get_tree().create_timer(5), "timeout")
	# Remove Projectile
	setActive(false)
	self.position = get_parent().get_node("SpellOrigin").global_position
