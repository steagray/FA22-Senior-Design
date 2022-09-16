extends KinematicBody2D

enum elem {FIRE, WATER, EARTH, AIR}


# Declare member variables here.

var speed = 5
var health = 4
var spellOne = elem.FIRE
var spellTwo = elem.WATER
var soCD_MAX = 5
var stCD_MAX = 5
var soCD = 0  # Cooldown time for Spell One in seconds
var stCD = 0  # Cooldown time for Spell Two in seconds
var canMove = true
var casting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if soCD > 0:
		soCD -= delta
		print(soCD)
	if stCD > 0:
		stCD -= delta
		print(stCD)
	if Input.is_action_pressed("ui_right") and canMove:
		move_and_collide(Vector2.RIGHT * speed)
	if Input.is_action_pressed("ui_down") and canMove:
		move_and_collide(Vector2.DOWN * speed)
	if Input.is_action_pressed("ui_up") and canMove:
		move_and_collide(Vector2.UP * speed)
	if Input.is_action_pressed("ui_left") and canMove:
		move_and_collide(Vector2.LEFT * speed)

func _input(event):
	if event.is_action_pressed("spell_one") and not soCD > 0:
		soCD = soCD_MAX
	if event.is_action_pressed("spell_two") and not stCD > 0:
		stCD = stCD_MAX

func healthdown():
	health -= 1
	if health == 0:
		print("I am die, thank you 4eva")
		canMove = false
	if health < 0:
		canMove = true
		health = 4
		print("RESPAWN")

func _on_Button_pressed():
	healthdown()

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	healthdown()
