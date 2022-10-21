extends KinematicBody2D



# Declare member variables here.
var invulnTimer : Timer
var velocity = Vector2.ZERO

signal onDamage


# Called when the node enters the scene tree for the first time.
func _ready():
	invulnTimer = Timer.new()
	invulnTimer.one_shot = true
	self.add_child(invulnTimer)
	# Set up Player UI
	var UI = load("res://Scenes/UI.tscn").instance()
	
	self.connect("onDamage", UI.get_node("HealthBar"), "on_onDamage")
	var Player = load("res://Scenes/Player.tscn")
	$PlayerCam.add_child(UI)

# Called when the node is about to leave SceneTree upon freeing or scene changing
func _exit_tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Cooldown timer
	if spellone.currCD > 0:
		spellone.currCD -= delta
	if spelltwo.currCD > 0:
		spelltwo.currCD -= delta
	
	# Movement handling
	velocity = Vector2.ZERO
	if stats.canMove:
		if Input.is_action_pressed("ui_right"):
			velocity += Vector2.RIGHT
			rotation_degrees = 90
		if Input.is_action_pressed("ui_down"):
			velocity += Vector2.DOWN
			rotation_degrees = 180
		if Input.is_action_pressed("ui_up"):
			velocity += Vector2.UP
			rotation_degrees = 0
		if Input.is_action_pressed("ui_left"):
			velocity += Vector2.LEFT
			rotation_degrees = 270
		$PlayerCam.rotation_degrees = 360 - rotation_degrees
		move_and_slide(velocity.normalized() * 750)

func _input(event):
	# Spell Casting	
	if event.is_action_pressed("spell_one") and spellone.active:
		spellone.castSpell(self)
	if event.is_action_pressed("spell_two") and spelltwo.active:
		spelltwo.castSpell(self)

func death():
	if stats.health > 0:
		stats.health = 0
		emit_signal("onDamage")
	
	print("I am die, thank you 4eva")
	stats.canMove = false
	for i in range(1, 9):
		rotation_degrees += 90
		$PlayerCam.rotation_degrees -= 90
		yield(get_tree().create_timer(0.1), "timeout")

func takedmg():
	# Invulnerability timer
	if not invulnTimer.time_left > 0:
		print("Ow!")
		stats.health -= 1
		emit_signal("onDamage")
		invulnTimer.start(2)
		if stats.health == 0:
			death()
