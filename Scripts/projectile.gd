extends Node

func _body_entered(body):
	print("Collision")
	if body.has_method("takedmg"):
		body.takedmg()
	queue_free()
