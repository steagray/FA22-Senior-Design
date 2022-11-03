extends Area2D

var timeFlying
var speed = -10


func _ready():
	pass


func _physics_process(delta):
	move_local_y(speed)



func _on_Bullet_body_entered(body):
	if body.has_method("take_dmg"):
		body.take_dmg()
	queue_free()
