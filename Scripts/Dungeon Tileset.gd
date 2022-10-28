extends TileMap

# used to store our particles and room locks/plate states when they enter the scene.
var BreakDoorParticles
var MakeDoorParticles
var ActivatePlateParticles
var PlateWaitingParticles
var Room1Locked = false
var Room1Locks = [false, false, false]
var Room2Plates = [false, false, false]
var Room3WaitPlate = false
var Room3Timer = false
var Room3Completed = false
var Room4Plates = [false, false, false, false]

# for erasing tiles with *style*
func wait(seconds):
	yield(get_tree().create_timer(seconds), "timeout")

func set_tile(x, y, particles, tileID):
	set_cell(x, y, tileID)
	particles.position = map_to_world(Vector2(x, y)) + Vector2(32, 32)

func activate_plate_paricles(x, y):
	ActivatePlateParticles.emitting = true
	ActivatePlateParticles.position = map_to_world(Vector2(x,y))
	yield(get_tree().create_timer(0.25), "timeout")
	ActivatePlateParticles.emitting = false
# Called when the node enters the scene tree for the first time.

func open_vertical_door(x, startY, endY):
	BreakDoorParticles.emitting = true
	for y in range(startY, endY + 1):
		if get_cell(x, y) != 1:
			set_tile(x, y, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
	BreakDoorParticles.emitting = false
	
func close_vertical_door(x, startY, endY):
	MakeDoorParticles.emitting = true
	for y in range(startY, endY + 1):
		if get_cell(x, y) != 0:
			set_tile(x, y, MakeDoorParticles, 0)
			yield(get_tree().create_timer(0.15), "timeout")
	MakeDoorParticles.emitting = false
	
func open_horizontal_door(startX, endX, y):
	BreakDoorParticles.emitting = true
	for x in range(startX, endX + 1):
		if get_cell(x, y) != 1:
			set_tile(x, y, BreakDoorParticles, 1)
			yield(get_tree().create_timer(0.15), "timeout")
	BreakDoorParticles.emitting = false
	
func close_horizontal_door(startX, endX, y):
	MakeDoorParticles.emitting = true
	for x in range(startX, endX + 1):
		if get_cell(x, y) != 0:
			set_tile(x, y, MakeDoorParticles, 0)
			yield(get_tree().create_timer(0.15), "timeout")
	MakeDoorParticles.emitting = false

func timed_vertical_door(x, startY, endY, time):
	open_vertical_door(x, startY, endY)
	yield(get_tree().create_timer(time), "timeout")
	close_vertical_door(x, startY, endY)
	
func timed_horizontal_door(startX, endX, y, time):
	open_horizontal_door(startX, endX, y)
	yield(get_tree().create_timer(time), "timeout")
	close_horizontal_door(startX, endX, y)

func _ready():
	var particles = get_tree().get_root().get_children()[3].get_children()[4].get_children()
	BreakDoorParticles = particles[0]
	MakeDoorParticles = particles[1]
	ActivatePlateParticles = particles[2]
	PlateWaitingParticles = particles[3]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func DoorTrigger(body):
	var x = 15 #the x value of our door
	activate_plate_paricles(12,4)
	open_vertical_door(x, 1, 6)

func LockRoom1(body):
	if Room1Locks[0] == false and Room1Locks[1] == false and Room1Locks[2] == false:
		if Room1Locked == false and Room1Locks[0] == false:
			close_vertical_door(27, 5, 6)
		Room1Locked = true

func OpenRoom1(body):
	# if we can open the door...
	if Room1Locks[0] == true and Room1Locks[1] == true and Room1Locks[2] == true and Room1Locked == true:
		activate_plate_paricles(43, 8)
		open_horizontal_door(41, 44, 10)
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
		close_horizontal_door(41, 44, 10)

func _on_Room2Plate1_body_entered(body):
	if Room2Plates[0] == false:
		Room2Plates[0] = true
		activate_plate_paricles(30,14)
		open_horizontal_door(28, 32, 16)

func _on_Room2Plate2_body_entered(body):
	if Room2Plates[1] == false:
		Room2Plates[1] = true
		activate_plate_paricles(43, 19)
		open_horizontal_door(41, 44, 21)

func _on_Room2Plate3_body_entered(body):
	if Room2Plates[2] == false:
		activate_plate_paricles(43, 25)
		timed_vertical_door(27, 23, 26, 3)

func _on_OpenRoom3_body_entered(body):
	if body.get_instance_id() == get_tree().get_root().get_children()[3].get_children()[3].get_instance_id():
		activate_plate_paricles(21, 15)
		timed_vertical_door(15, 13, 16, 1)

func _on_WaitPlateTrigger_body_entered(body):
	if body.get_instance_id() == get_tree().get_root().get_children()[3].get_children()[3].get_instance_id() and Room3WaitPlate == false:
		PlateWaitingParticles.position = map_to_world(Vector2(9, 15))
		PlateWaitingParticles.emitting = true
		Room3Timer = true
		yield(get_tree().create_timer(5), "timeout")
		if Room3Timer == true:
			Room3WaitPlate = true
			open_horizontal_door(7, 10, 18)

func _on_WaitPlateTrigger_body_exited(body):
	if body.get_instance_id() == get_tree().get_root().get_children()[3].get_children()[3].get_instance_id():
		PlateWaitingParticles.position = map_to_world(Vector2(9, 15))
		PlateWaitingParticles.emitting = false
		Room3Timer = false

func _on_Room3Plate2_body_entered(body):
	if body.get_instance_id() == get_tree().get_root().get_children()[3].get_children()[3].get_instance_id() and Room3Completed == false:
		Room3Completed = true
		activate_plate_paricles(9,21)
		open_vertical_door(-3, 16, 20)


func _on_Plate1_body_entered(body):
	if Room4Plates[0] == false:
		Room4Plates[0] = true
		activate_plate_paricles(-15,2)
		open_vertical_door(-58, 20, 23)


func _on_Plate2_body_entered(body):
	if Room4Plates[1] == false:
		Room4Plates[1] = true
		activate_plate_paricles(-65,2)
		open_vertical_door(-61, 20, 23)

func _on_Plate3_body_entered(body):
	if Room4Plates[2] == false:
		Room4Plates[2] = true
		activate_plate_paricles(-61,35)
		open_vertical_door(-64, 20, 23)

func _on_Plate4_body_entered(body):
	if Room4Plates[3] == false:
		Room4Plates[3] = true
		activate_plate_paricles(-22,38)
		open_vertical_door(-67, 20, 23)
