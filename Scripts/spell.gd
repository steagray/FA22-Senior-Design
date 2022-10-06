extends Node
class_name spell

enum elem {FIRE, WATER, EARTH, AIR}

# Declare member variables here.
var element = elem.FIRE
var maxCD = 5
var currCD = 0
var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func castSpell():
	if currCD > 0:
		return
	stats.canMove = false
	# create projectile
	var projectile = Area2D.new()
	projectile.add_child(CollisionShape2D.new())
	projectile.get_child(0).shape = RectangleShape2D.new()
	projectile.get_child(0).shape.extents.x = 30
	projectile.get_child(0).shape.extents.y = 30
	projectile.collision_layer = 10
	projectile.add_child(Sprite.new())
	var sprimg = Image.new()
	sprimg.load("res://Icon.png")
	projectile.get_child(1).texture = ImageTexture.new().create_from_image(sprimg)
	print(projectile)
	print(projectile.get_child(0))
	print(projectile.get_child(1))
	print(projectile.position)
	print(get_tree().root.get_node("KinematicPlayer2D").position)
	projectile.position = get_tree().root.get_node("KinematicPlayer2D").position
	projectile.visible = true
	
	yield(get_tree().create_timer(stats.castTimer_MAX), "timeout")
	stats.canMove = true
	currCD = maxCD


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
