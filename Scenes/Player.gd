extends KinematicBody2D

enum elem {FIRE, WATER, EARTH, AIR}


# Declare member variables here.

var speed = 5  # Movement speed
var health = 4  # Health
var spellOne = {
	"elem": elem.FIRE,
	"maxCD": 5,
	"currCD": 0,
	"upgrades": []
}
var spellTwo = {
	"elem": elem.FIRE,
	"maxCD": 5,
	"currCD": 0,
	"upgrades": []
}
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
	if spellOne.currCD > 0:
		spellOne.currCD -= delta
	if spellTwo.currCD > 0:
		spellTwo.currCD -= delta
	
	# Movement handling
	if Input.is_action_pressed("ui_right") and canMove:
		move_and_collide(Vector2.RIGHT * speed)
	if Input.is_action_pressed("ui_down") and canMove:
		move_and_collide(Vector2.DOWN * speed)
	if Input.is_action_pressed("ui_up") and canMove:
		move_and_collide(Vector2.UP * speed)
	if Input.is_action_pressed("ui_left") and canMove:
		move_and_collide(Vector2.LEFT * speed)

func _input(event):
	if event.is_action_pressed("spell_one"):
		castSpell(spellOne)
	if event.is_action_pressed("spell_two"):
		castSpell(spellTwo)

func takedmg():
	health -= 1
	if health == 0:
		print("I am die, thank you 4eva")
		canMove = false

func castSpell(spell):
	if spell.currCD > 0:
		return
	spell.currCD = spell.maxCD

func _on_Button_pressed():
	takedmg()
	if health < 0:
		canMove = true
		health = 4
		print("RESPAWN")
