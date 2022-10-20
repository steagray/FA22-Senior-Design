extends TileMap

# used to store our particles and room locks/plate states when they enter the scene.
var BreakDoorParticles
var MakeDoorParticles
var ActivatePlateParticles
var Room1Locked = false
var Room1Locks = [false, false, false]
var Room2Plates = [false, false, false]

# for erasing tiles with *style*
func set_tile(x, y, particles, tileID):
	set_cell(x, y, tileID)
	particles.position = map_to_world(Vector2(x, y)) + Vector2(32, 32)

func activate_plate_paricles(x, y):
	ActivatePlateParticles.emitting = true
	ActivatePlateParticles.position = map_to_world(Vector2(x,y))
	yield(get_tree().create_timer(0.25), "timeout")
	ActivatePlateParticles.emitting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var particles = get_tree().get_root().get_children()[3].get_children()[4].get_children()
	BreakDoorParticles = particles[0]
	MakeDoorParticles = particles[1]
	ActivatePlateParticles = particles[2]


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
		activate_plate_paricles(43, 8)
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
		activate_plate_paricles(32,2)

func _on_Room1Plate2_body_entered(body):
	if Room1Locks[1] == false:
		Room1Locks[1] = true
		activate_plate_paricles(41,2)

func _on_Room1Plate3_body_entered(body):
	if Room1Locks[2] == false:
		Room1Locks[2] = true
		activate_plate_paricles(32,7)

func LockRoom2(body):
	if body.get_instance_id() == get_tree().get_root().get_children()[3].get_children()[3].get_instance_id():
		var y = 10
		MakeDoorParticles.emitting = true
		for i in range(41, 45):
			set_tile(i, y, MakeDoorParticles, 0)
			yield(get_tree().create_timer(0.15), "timeout")
		MakeDoorParticles.emitting = false

func _on_Room2Plate1_body_entered(body):
	if Room2Plates[0] == false:
		Room2Plates[0] = true
		activate_plate_paricles(30,14)
		BreakDoorParticles.emitting = true
		var y = 16
		for x in range(28, 33):
			set_tile(x, y, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
		BreakDoorParticles.emitting = false

func _on_Room2Plate2_body_entered(body):
	if Room2Plates[1] == false:
		Room2Plates[1] = true
		activate_plate_paricles(43, 19)
		BreakDoorParticles.emitting = true
		var y = 21
		for x in range(41, 45):
			set_tile(x, y, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
		BreakDoorParticles.emitting = false

func _on_Room2Plate3_body_entered(body):
	if Room2Plates[2] == false:
		activate_plate_paricles(43, 25)
		var x = 27
		#23 -27
		BreakDoorParticles.emitting = true
		for y in range(23, 27):
			set_tile(x, y, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
		BreakDoorParticles.emitting = false
		
		yield(get_tree().create_timer(3), "timeout")
		
		MakeDoorParticles.emitting = true
		for y in range(23, 27):
			set_tile(x, y, MakeDoorParticles, 0)
			yield(get_tree().create_timer(0.15), "timeout")
		MakeDoorParticles.emitting = false
