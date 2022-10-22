extends KinematicBody2D



# Declare member variables here.
var invulnTimer : Timer

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
	if stats.canMove:
		if Input.is_action_pressed("ui_right"):
			move_and_collide(Vector2.RIGHT * stats.speed)
			rotation_degrees = 90
		if Input.is_action_pressed("ui_down"):
			move_and_collide(Vector2.DOWN * stats.speed)
			rotation_degrees = 180
		if Input.is_action_pressed("ui_up"):
			move_and_collide(Vector2.UP * stats.speed)
			rotation_degrees = 0
		if Input.is_action_pressed("ui_left"):
			move_and_collide(Vector2.LEFT * stats.speed)
			rotation_degrees = 270
		$PlayerCam.rotation_degrees = 360 - rotation_degrees

func _input(event):
	# Spell Casting	
	if event.is_action_pressed("spell_one") and spellone.active:
		spellone.castSpell(self)
	if event.is_action_pressed("spell_two") and spelltwo.active:
		spelltwo.castSpell(self)

func takedmg():
	# Invulnerability timer
	if not invulnTimer.time_left > 0:
		#print("Ow!")
		$Particles2D.emitting = true
		$Particles2D.restart()
		stats.health -= 1
		emit_signal("onDamage")
		invulnTimer.start(2)
		if stats.health == 0:
			$Particles2D.amount = 500
			$Particles2D.emitting = true
			print("I am die, thank you 4eva")
			stats.canMove = false
