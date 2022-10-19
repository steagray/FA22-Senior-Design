extends TileMap

# used to store our particles and room locks/plate states when they enter the scene.  DO NOT GET RID OF THIS
var BreakDoorParticles
var MakeDoorParticles
var ActivatePlateParticles
var Room1Locked = false
var Room1Locks = [false, false, false]

# for erasing tiles with *style*
func set_tile(x, y, particles, tileID):
	set_cell(x, y, tileID)
	particles.position = map_to_world(Vector2(x, y)) + Vector2(32, 32)

# Called when the node enters the scene tree for the first time.
func _ready():
	BreakDoorParticles = get_tree().get_root().get_children()[3].get_children()[6].get_children()[0]
	MakeDoorParticles = get_tree().get_root().get_children()[3].get_children()[6].get_children()[1]
	ActivatePlateParticles = get_tree().get_root().get_children()[3].get_children()[6].get_children()[2]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func DoorTrigger(body):
	var x = 15 #the x value of our door
	BreakDoorParticles.emitting = true
	for i in range(1, 7):
		#i is the y value of our cell
		if get_cell(x, i) != 1:
			set_tile(x, i, BreakDoorParticles, 1)
			#print(map_to_world(Vector2(15, i)))
			yield(get_tree().create_timer(0.15), "timeout")
	BreakDoorParticles.emitting = false

func LockRoom1(body):
	if Room1Locks[0] == false and Room1Locks[1] == false and Room1Locks[2] == false:
		var x = 27 # the x value of the "lockout door"
		MakeDoorParticles.emitting = true
		for i in range(5, 7):
			if Room1Locked == false and Room1Locks[0] == false:
				# do stuff
				set_tile(x, i, MakeDoorParticles, 0)
				yield(get_tree().create_timer(0.15), "timeout")
		MakeDoorParticles.emitting = false
		Room1Locked = true

func OpenRoom1(body):
	# if we can open the door...
	if Room1Locks[0] == true and Room1Locks[1] == true and Room1Locks[2] == true and Room1Locked == true:
		var y = 10 # the y value of the "open shit up" door
		BreakDoorParticles.emitting = true
		for i in range(41, 45):
			set_tile(i, y, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
		var x = 27
		for i in range(5, 7):
			set_tile(x, i, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
		BreakDoorParticles.emitting = false
		BreakDoorParticles.position = map_to_world(Vector2(-5000, -5000))
		Room1Locked = false

func _on_Room1Plate1_body_entered(body):
	if Room1Locks[0] == false:
		Room1Locks[0] = true
		ActivatePlateParticles.emitting = true
		ActivatePlateParticles.position = map_to_world(Vector2(32, 2))
		yield(get_tree().create_timer(0.25), "timeout")
		ActivatePlateParticles.emitting = false

func _on_Room1Plate2_body_entered(body):
	if Room1Locks[1] == false:
		Room1Locks[1] = true
		ActivatePlateParticles.emitting = true
		ActivatePlateParticles.position = map_to_world(Vector2(41, 2))
		yield(get_tree().create_timer(0.25), "timeout")
		ActivatePlateParticles.emitting = false

func _on_Room1Plate3_body_entered(body):
	if Room1Locks[2] == false:
		Room1Locks[2] = true
		ActivatePlateParticles.emitting = true
		ActivatePlateParticles.position = map_to_world(Vector2(32, 7))
		yield(get_tree().create_timer(0.25), "timeout")
		ActivatePlateParticles.emitting = false
