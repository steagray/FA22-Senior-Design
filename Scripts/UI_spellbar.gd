extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spellobj = spellone

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = spellobj.maxCD


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = spellobj.currCD
