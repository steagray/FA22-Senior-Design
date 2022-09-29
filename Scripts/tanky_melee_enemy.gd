extends KinematicBody2D

var enemy_health = 2
var can_move = true
var attack_cooldown = 2

func _ready():
	pass # Replace with function body.

# Called when the node is about to leave SceneTree upon freeing or scene changing
func _exit_tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):

# Function call for taking damage. Removes sprite from scene when killed
func takedmg():
	enemy_health -= 1
	if enemy_health <= 0:
		can_move = false
		queue_free()
		print("Tango Down")


func _on_Button_pressed():
	takedmg();
