extends "res://Scripts/tanky_melee_enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal HealthGate

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health = 15
	self.speed = 150

func teleport():
	$TeleportParticles.emitting = true
	$TeleportParticles.restart()

func takedmg():
	health -= 1
	if health % 5 == 0:
		$TeleportParticles.local_coords = true
		teleport()
		yield(get_tree().create_timer(1), "timeout")
		$TeleportParticles.local_coords = false
		$TeleportParticles.emitting = false
		self.position = Vector2(-13714,1188)
		emit_signal("HealthGate")
	if health <= 0:
		death()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BossMechanicCompleted():
	self.position = Vector2(-7341,1421)
	$TeleportParticles.local_coords = true
	teleport()
	yield(get_tree().create_timer(1), "timeout")
	$TeleportParticles.local_coords = false
	$TeleportParticles.emitting = false
	pass # Replace with function body.
