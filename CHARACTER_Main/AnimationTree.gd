extends AnimationTree


# Declare member variables here. Examples:
var playback : AnimationNodeStateMachinePlayback

# Called when the node enters the scene tree for the first time.
func _ready():
	playback = get("parameters/playback")
	playback.start("Idle-loop")
		#^For some reason...
	
	active = true	#This should be on automatically, but tutorial does this just in case.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
