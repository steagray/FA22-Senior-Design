extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 250
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_node("Node2D/KinematicPlayer2D")

func _physics_process(delta):
	move_and_slide(velocity)
	lineUp()

func lineUp():
	var distx = player.position.x - self.position.x
	var disty = player.position.y - self.position.y
	if abs(distx) <= 20 || abs(disty) <= 20:
		velocity = Vector2.ZERO
		return 
	
	if abs(distx) < abs(disty):
		# Attempt to line up horizontally
		velocity = Vector2(speed * (distx/abs(distx)), 0)
	elif abs(disty) < abs(distx):
		# Attempt to line up vertically
		velocity = Vector2(0, speed * (disty/abs(disty)))
	else:
		velocity = Vector2.ZERO

func shoot():
	pass
