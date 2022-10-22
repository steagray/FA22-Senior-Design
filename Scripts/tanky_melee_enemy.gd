extends KinematicBody2D

var health = 2
var attack_cooldown = 2
var speed = 500
var velocity
var isAggro = 0
var player
var inrange : bool = false

signal playerCollide
signal death

func _ready():
	player = get_tree().root.get_node("Node2D/KinematicPlayer2D")
	velocity = Vector2.ZERO
	self.connect("playerCollide", player, "takedmg")

# Called when the node is about to leave SceneTree upon freeing or scene changing
func _exit_tree():
	emit_signal("death")


func _physics_process(delta):
	move_and_slide(velocity)
	if get_slide_count() != 0:
		if get_slide_collision(get_slide_count() - 1).collider_id == player.get_instance_id():
			emit_signal("playerCollide")
		else:
			move_and_slide(Vector2(velocity.y, velocity.x))

func death():
	queue_free()

# Function call for taking damage. Removes instance from tree when health reaches 0
func takedmg():
	health -= 1
	if health <= 0:
		death()

func setAggro(x):
	isAggro = x

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


func _on_PlayerEnter(body):
	inrange = true
	if body.get_instance_id() == player.get_instance_id():
		setAggro(1)

func _on_PlayerExit(body):
	inrange = false
	if body.get_instance_id() == player.get_instance_id():
		yield(get_tree().create_timer(3), "timeout")
		if not inrange:
			setAggro(0)
