extends KinematicBody
####THIS SCRIPT IS USED TO CONNECT SIGNALS BETWEEN SIBLING NODES!

#So it doesn't have any actual move_slide kinmatic code
#at least right now.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$DIALOGUE_INDICATOR_Sprite3DNode.connect("makeCamCurrent_NPC_signal", $DIALOGUE_CameraNode, "CamSwitchTo_WhoeverIsTalking_function")
	#$DIALOGUE_INDICTATOR_etc is the node that's EMITTING the signal
		#the connect() function connects the signal to the other node and has 3 argumets:
			#1) "makeCamCurrent_NPC01" is the NAME of the SIGNAL emitted.
				#   " USE QUOTATAION MARKS "
			#2) $DIALOGUE_CameraNode is the node that RECEIVES the signal and that HAS THE CODE for the functyion you want ot run whenever the signal's emitted.
			#3) "CamSwitchTo_NPC_function" is the NAME of that FUNCTION.
				#   " USE QUOTATAION MARKS "
				


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
