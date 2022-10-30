extends Area2D

func _ready():
	pass



func _on_Reward_body_exited(body):
	queue_free()
