extends CanvasLayer

#THANKS TO:
	#Touchscreen tutorial: https://www.youtube.com/watch?v=_VXtUTwTxP0
	#Multiple Touch Inputs Not Interfereing With Each OTher:
		#Billyb's answer:https://godotengine.org/qa/28958/someone-please-explain-touch-index-handling-trying-analog
	#Make screen size and touch button location consistent:
	#https://youtu.be/gkY6X-bziHQ?t=93
	#@1:33
	
	# ROTATE CAMERA:
		#Pt1) How to Rotate Camera:
		#https://www.youtube.com/watch?v=Bch-OagnX1E&t=46s
		
		#Pt2) Fix Character Movement At Diff Cam Angles:
		#https://youtu.be/5adTaWiCWvM?t=204
		#@3:23

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var RADIUSofBOUNDARYofJoystick = Vector2(50,50)

onready var joystickNODE = get_node("JOYSTICK_TouchScreenButton")
onready var regionNODE = get_node("REGIONofJoystick_TouchScreenButton") 
# Called when the node enters the scene tree for the first time.
onready var jumpNODE = get_node("JUMP_TouchScreenButton")
onready var dashNODE = get_node("DASH_TouchScreenButton")

var touchID_JOYSTICK = -1
var touchID_ACTION_FACE_BUTTONS = -1
#Explanation: a value of -1 means OFF. i.e. we are not touching the touch-button.
#A value of 0 means the first finger that touched the screen.
#A value of 1 refers to the 2nd finger that's touching the screen. 

#Signal Variables:
signal use_move_vector
#Turns out I don't need this code to keep jump touch button from interfering with touch joystick.
#I just needed to connect a signal from the jump touch button node to kinematic node,
#instead of ...
#Uh...
#I'm not 100% why it works.
# but deleting the jump signal from the canvas node, jump still works
# jump still works as long as the jump touch node's signal is connected to the kinematic body node.
#signal jumpSIGNAL



#ANIMATION TREE VARIABLES:
onready var animTreeNode = get_parent().get_node("CHAR EXPORT ONLY LOWER POLY Char for Game/AnimationTree")

func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	#If touchID is off (i.e. -1) BUT you turn it on by touching or dragging:
	if touchID_JOYSTICK == -1 and (event is InputEventScreenTouch) and event.pressed == true and (joystickNODE.is_pressed() or regionNODE.is_pressed() == true):
	#IMPORTANT!!!! do not use event.pressed() with brackets! Or it won't work! Even though i thought pressed() is proper.
		#Switch touchID on by assigning a value of whatever touch index just switched it on:
		touchID_JOYSTICK = event.index

		
	#Turns out I don't need this code to keep jump touch button from interfering with touch joystick.
	#Read notes at top under "Signal Variables" for details.
#	if touchID_ACTION_FACE_BUTTONS == -1 and (event is InputEventScreenTouch) and event.pressed == true and (jumpNODE.is_pressed() or dashNODE.is_pressed() == true):
#		touchID_ACTION_FACE_BUTTONS = event.index

		
	#Otherwise:
	#If any touch input happens AND this touch happens to be the touchID we just turned on:
	elif (event is InputEventScreenTouch or event is InputEventScreenDrag) and event.index == touchID_JOYSTICK:
	#ALSO IMPORTANT!!! (event is touch) must come before "and event.index ==...
	#because if you put event.index == touchID first, then the game will break if you try to use any other non-touch input like mouse movement or keyboard press. 

	
		#Run your touch-button-pressing code:
		if ( joystickNODE.is_pressed() == true or regionNODE.is_pressed() == true ) and event.index == touchID_JOYSTICK:

			#Run a function we made that calculates the touchscreen joystick's direction:
			var move_vector = calculate_move_vector(event.position)
			
			#And then emit the value returned by this fucntion so that a different node can use it:
			emit_signal("use_move_vector", move_vector)
			
			#Play the run_startup animation and then play the looping run animation:

			if move_vector != Vector2.ZERO:
				animTreeNode.playback.travel("Run2LoopAnim-loop") #This isn't fixing the no-looping problem! tbc
		#If we're not touching joystick or joystick region:
		if joystickNODE.is_pressed() == false and !regionNODE.is_pressed():
			#Reset character's horizontal velocity:
			get_parent().velocityChar.x = 0
			get_parent().velocityChar.z = 0
			touchID_JOYSTICK = -1
			#Or else character will keep moving even after you let go of touch joystick!

			#Play the slowing_down animation and then play the idle anim:
			animTreeNode.playback.travel("Idle")
			

	#Turns out I don't need this code to keep jump touch button from interfering with touch joystick.
	#Read notes at top under "Signal Variables" for details.
	#I've read the code while thinking what if I press the jump button first,
	#and I think separating movement button if-statement(s) from jump and dash buttons might help:
#	elif (event is InputEventScreenTouch or event is InputEventScreenDrag) and event.index == touchID_ACTION_FACE_BUTTONS:
#		if jumpNODE.is_pressed() == true:
#			#DEBUG: every 2nd jump is much higher for some reasoen!
#			#What's the char's vert velocity b4 jumping? 
#
##			get___parent().velocityChar.y = 0 #Don't do this here. It prevents more than one jump.
#			emit_signal("jumpSIGNAL")
#			#^This method makes the jump button fire INFINITE TIMES IF YOU DRAG ON THE JUM PBUTTON!!!
#			#I need jump to only happen once.
#			#Oh wait. I need a is-on-floor requirement for jump duh!
#
	#Turns out I don't need this code to keep jump touch button from interfering with touch joystick.
	#Read notes at top under "Signal Variables" for details.
#		if dashNODE.is_pressed() == true:
#
#		elif jumpNODE.is_pressed() == false and dashNODE.is_pressed() == false:
#			touchID_ACTION_FACE_BUTTONS = -1
	
	
	#Otherwise:
	#If any touchscreen input happens AND this happens to be the touchID we just turned on BUT it's no longer pressed i.e. we let go of the touch button:
	elif  (event is InputEventScreenTouch or event is InputEventScreenDrag) and event.index == touchID_JOYSTICK and event.pressed == false:
		#FLip the switch to OFF:

		touchID_JOYSTICK = -1

	#Turns out I don't need this code to keep jump touch button from interfering with touch joystick.
	#Read notes at top under "Signal Variables" for details.
#	elif  (event is InputEventScreenTouch or event is InputEventScreenDrag) and event.index == touchID_ACTION_FACE_BUTTONS and event.pressed == false:
#		#FLip the switch to OFF:
#		touchID_ACTION_FACE_BUTTONS = -1



func calculate_move_vector(event_position):
	var texture_center = joystickNODE.position + RADIUSofBOUNDARYofJoystick
	
	#ROTATE CHAR WITH CAMERA
	#In order to get proper 3d platformer camera rotation,
	#we need to rotate the character while rotating the camer,a too.
	#Otherwise, you'll Resident-Evil-style "tank" controls in a Mario Odyssey-type game!
	#i.e. tilting upwards on joystick will always make your character move northwards,
	#evne if the camera angle changed and made north NOt the top of your screen.
	#!!!!!!
	var rotate_char_with_camera = -get_parent().get_node("CAMERA_ROOT_SpatialNode/HORIZONTAL_CAM_ROTATE_SpatialNode").global_transform.basis.get_euler().y
	# put a minus in front, or else character moves in wrong directions at certain camera angles
	# Note that we are rotating the node's position.
	# get_euler().y is needed to make it global or something.
	
	var tempJoystickValue = event_position - texture_center
	var tempMovementDirection = tempJoystickValue.rotated(rotate_char_with_camera)
	return tempMovementDirection.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
