extends Area2D

func _ready():
	pass

# Healing is handled in Player.gd as another signal

func _on_Reward_body_exited(body):
	# This prevents infinite healing, if they player
	# Doesn't reach max health with one use
	queue_free()
