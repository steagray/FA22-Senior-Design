extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 250
var player
var i = 0
var health = 1
var bulletLoader

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_node("Node2D/KinematicPlayer2D")
	bulletLoader = load("res://Scenes/og_unit_bullet.tscn")

func _physics_process(delta):
	move_and_slide(velocity)
	lineUp()

func lineUp():
	var distx = player.position.x - self.position.x
	var disty = player.position.y - self.position.y
	
	if abs(distx) < abs(disty):
		# Attempt to line up vertically and face player
		velocity = Vector2(speed * (distx/abs(distx)), 0)
		if disty > 0:
			rotation_degrees = 90
		if disty < 0:
			rotation_degrees = 270
	if abs(disty) < abs(distx):
		# Attempt to line up horizontally and face player
		velocity = Vector2(0, speed * (disty/abs(disty)))
		if distx < 0:
			rotation_degrees = 180
		if distx > 0:
			rotation_degrees = 0
	# If lined up, stop moving and fire a shot
	if abs(distx) <= 20 || abs(disty) <= 20:
		velocity = Vector2.ZERO

func shoot():
	$pew.play() # actually needs an SFX
	
	var bullet = bulletLoader.instance()
	
	get_parent().add_child(bullet)
	
	bullet.position = get_node("SpellOrigin").global_position
	bullet.rotation = get_node("SpellOrigin").global_rotation
	
	pass


func _on_AimingLine_body_entered(body):
	if body.get_instance_id() == player.get_instance_id():
		if not $Cooldown.time_left > 0:
			$Cooldown.start()
			yield(get_tree().create_timer(1), "timeout")
			i += 1
			shoot()

func death():
	queue_free()

func takedmg():
	health -= 1
	if health <= 0:
		death()
