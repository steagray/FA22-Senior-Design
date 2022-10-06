extends KinematicBody2D

var enemy_health = 2
var attack_cooldown = 2
var speed = 500
var velocity
var isAggro
var player

signal playerCollide

func _ready():
	_on_BehaviorTimer_timeout()
	player = get_tree().root.get_node("Node2D/KinematicPlayer2D")
	velocity = Vector2.ZERO
	self.connect("playerCollide", player, "takedmg")

# Called when the node is about to leave SceneTree upon freeing or scene changing
func _exit_tree():
	pass

func _process(delta):
	move_and_slide(velocity)
	if get_slide_count() != 0:
		if get_slide_collision(get_slide_count() - 1).collider_id == player.get_instance_id():
			print("PLAYER " + str(get_slide_count()))
			move_and_slide(Vector2(velocity.y, velocity.x))

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
	if isAggro:
		$MovementTimer.wait_time = 0.25
	else:
		$MovementTimer.wait_time = 1


func _on_MovementTimer_timeout():
	var distx = player.position.x - self.position.x # if neg, left of. if pos, right of
	var disty = player.position.y - self.position.y # if neg, above. if pos, below
	
	if isAggro:
		if abs(distx) > abs(disty) || abs(disty) < 64:
			velocity = Vector2(speed * (distx / abs(distx)), 0)
		elif abs(disty) > abs(distx) || abs(distx) < 64:
			velocity = Vector2(0, speed * disty / abs(disty))
		else:
			velocity = Vector2(0, speed * disty / abs(disty))
	else:
		match (randi() % 5):
			0: 
				velocity = Vector2.ZERO
			1:
				velocity = Vector2.UP * speed
			2:
				velocity = Vector2.DOWN * speed
			3:
				velocity = Vector2.LEFT * speed
			4:
				velocity = Vector2.RIGHT * speed
