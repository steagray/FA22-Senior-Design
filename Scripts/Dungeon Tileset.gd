extends TileMap

# used to store our particles when they enter the scene.  DO NOT GET RID OF THIS
var particles

# for erasing tiles with *style*
func erase_door_tile(x, y, particles):
	set_cell(x, y, 1)
	particles.position = map_to_world(Vector2(x, y)) + Vector2(32, 32)
	#particles.restart()
	#particles.emitting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	particles = get_tree().get_root().get_children()[3].get_children()[6]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func DoorTrigger(body):
	var x = 15 #the x value of our door
	particles.emitting = true
	for i in range(1, 7):
		#i is the y value of our cell
		if get_cell(x, i) != 1:
			erase_door_tile(x, i, particles)
			#print(map_to_world(Vector2(15, i)))
			yield(get_tree().create_timer(0.15), "timeout")
	particles.emitting = false
