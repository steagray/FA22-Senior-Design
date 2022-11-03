extends KinematicBody2D



# Declare member variables here.
var invulnTimer : Timer
var velocity = Vector2.ZERO
var noTransfer = false

signal onDamage
signal onHeal
signal camTransfer


# Called when the node enters the scene tree for the first time.
func _ready():
	invulnTimer = Timer.new()
	invulnTimer.one_shot = true
	self.add_child(invulnTimer)
	# Set up Player UI
	var UI = load("res://Scenes/UI.tscn").instance()
	
	self.connect("onDamage", UI.get_node("HealthBar"), "on_onDamage")
	self.connect("onHeal", UI.get_node("HealthBar"), "on_onHeal")
	var Player = load("res://Scenes/Player.tscn")
	var camera = $PlayerCam
	if get_parent().get("camera") != null and not noTransfer:
		self.remove_child(camera)
		get_parent().call_deferred("add_child", camera)
		call_deferred("emit_signal", "camTransfer")
	camera.add_child(UI)
	


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
		if self.has_node("PlayerCam"):
			$PlayerCam.rotation_degrees = 360 - rotation_degrees
		move_and_slide(velocity.normalized() * 750)

func _input(event):
	# Spell Casting
	if stats.canMove:
		if event.is_action_pressed("spell_one") and spellone.active:
			spellone.castSpell(self)
		if event.is_action_pressed("spell_two") and spelltwo.active:
			spelltwo.castSpell(self)

func death():
	# Account for possible instant death attacks/hazards
	if stats.health > 0:
		stats.health = 0
		emit_signal("onDamage")
	
	print("I am die, thank you 4eva")
	stats.canMove = false
	for i in range(1, 9):
		rotation_degrees += 90
		if self.has_node("PlayerCam"):
			$PlayerCam.rotation_degrees -= 90
		yield(get_tree().create_timer(0.1), "timeout")

#This is used for enemy projectile collision, so that enemies don't friendly fire
func take_dmg():
	takedmg()

func takedmg():
	# Invulnerability timer
	if not invulnTimer.time_left > 0 and stats.health > 0:
		#print("Ow!")
		$Particles2D.emitting = true
		$Particles2D.restart()
		stats.health -= 1
		emit_signal("onDamage")
		invulnTimer.start(2)
		if not stats.health > 0:
			$Particles2D.amount = 500
			$Particles2D.emitting = true
			print("I am die, thank you 4eva")
			death()


func heal(amount):
	if (amount + stats.health) > stats.maxHP:
		stats.health = stats.maxHP
	else:
		stats.health += amount
	emit_signal("onHeal")

func _on_Reward_body_entered(body):
	if stats.health < stats.maxHP:
		heal(2)
