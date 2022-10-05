extends KinematicBody2D

var enemy_health = 2
var attack_cooldown = 2
var isAggro
var i = 0

func _ready():
	_on_BehaviorTimer_timeout()

# Called when the node is about to leave SceneTree upon freeing or scene changing
func _exit_tree():
	pass

func _process(delta):
	move_and_collide(Vector2.RIGHT)

func _input(event):
	move_and_collide(Vector2.UP)

# Function call for taking damage. Removes sprite from scene when killed
func takedmg():
	enemy_health -= 1
	if enemy_health <= 0:
		queue_free()
		print("Tango Down")


func _on_Button_pressed():
	takedmg();


func _on_BehaviorTimer_timeout():
	randomize()
	isAggro = randi() % 2
	print(isAggro)
