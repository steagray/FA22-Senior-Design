extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spellobj

# Called when the node enters the scene tree for the first time.
func _ready():
	spellobj = null
	pass
	
func setObj(obj):
	spellobj = obj
	max_value = spellobj.maxCD

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spellobj != null:
		value = spellobj.currCD
