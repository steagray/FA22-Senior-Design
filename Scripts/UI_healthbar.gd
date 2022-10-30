extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = 8
	value = stats.health

func on_onHeal():
	value = stats.health

func on_onDamage():
	value = stats.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

