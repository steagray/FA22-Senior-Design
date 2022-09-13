extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 5
var health = 4
var canMove = true;

signal confirmButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right") and canMove:
		print("Right")
		position += Vector2.RIGHT * speed
	if Input.is_action_pressed("ui_down") and canMove:
		print("Down")
		position += Vector2.DOWN * speed
	if Input.is_action_pressed("ui_up") and canMove:
		print("Up")
		position += Vector2.UP * speed
	if Input.is_action_pressed("ui_left") and canMove:
		print("Left")
		position += Vector2.LEFT * speed
	if Input.is_action_just_pressed("ui_accept") and canMove:
		emit_signal("confirmButton")

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


func _on_Icon2_pressed():
	print("Enter Pressed!")
	pass # Replace with function bod


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	healthdown()
