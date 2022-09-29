extends KinematicBody2D



# Declare member variables here.

#var speed = 10  # Movement speed

var castTimer = 0
var canMove = true  # Whether the player is able to move or not
var isCasting = false  # Whether player is currently casting a spell

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called when the node is about to leave SceneTree upon freeing or scene changing
func _exit_tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Cooldown timer
	if spellone.currCD > 0:
		spellone.currCD -= delta
	if spelltwo.currCD > 0:
		spelltwo.currCD -= delta
	
	# Cast delay
	if castTimer > 0:
		castTimer -= delta
	elif isCasting:
		isCasting = false
	
	# Movement handling
	if Input.is_action_pressed("ui_right") and canMove and not isCasting:
		move_and_collide(Vector2.RIGHT * stats.speed)
	if Input.is_action_pressed("ui_down") and canMove and not isCasting:
		move_and_collide(Vector2.DOWN * stats.speed)
	if Input.is_action_pressed("ui_up") and canMove and not isCasting:
		move_and_collide(Vector2.UP * stats.speed)
	if Input.is_action_pressed("ui_left") and canMove and not isCasting:
		move_and_collide(Vector2.LEFT * stats.speed)

func _input(event):
	if event.is_action_pressed("spell_one"):
		castSpell(spellone)
	if event.is_action_pressed("spell_two"):
		castSpell(spelltwo)
	if event.is_action_pressed("ui_right"):
		rotation_degrees = 90
	if event.is_action_pressed("ui_down"):
		rotation_degrees = 180
	if event.is_action_pressed("ui_up"):
		rotation_degrees = 0
	if event.is_action_pressed("ui_left"):
		rotation_degrees = 270

func takedmg():
	stats.health -= 1
	if stats.health == 0:
		print("I am die, thank you 4eva")
		canMove = false

func castSpell(spell):
	if spell.currCD > 0:
		return
	isCasting = true
	castTimer = stats.castTimer_MAX
	# Create projectile
	spell.currCD = spell.maxCD

func _on_Button_pressed():
	takedmg()
	if stats.health < 0:
		canMove = true
		stats.health = 4
		print("RESPAWN")


func _on_OverworldLoad_body_entered(body):
	print(body.get_instance_id())
	if body.get_instance_id() == 1328:
		
		get_tree().change_scene("res://Scenes/Overworld.tscn")
		return
	print(body)
