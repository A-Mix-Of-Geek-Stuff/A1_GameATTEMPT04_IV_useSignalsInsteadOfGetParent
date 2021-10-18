'Touch_controls_REPLACING_GET_PARENTS_WITH_SIGNALS
	NOTE: This script isn't even the main orbit-cam script!
	
	# But is #4 below a camera_line of code???
There are four get_parents in the TOUCH_CONTROL_CanvasLayer script:
	1) onready var
	2 & 3)
			#If we're not touching joystick or joystick region:
		if joystickNODE.is_pressed() == false and !regionNODE.is_pressed():
			#Reset character's horizontal velocity:
			get_parent().velocityChar.x = 0
			get_parent().velocityChar.z = 0
			touchID_JOYSTICK = -1
			#Or else character will keep moving even after you let go of touch joystick!
			####IDEA: set move_vector to 0,0 b4 emitting its signal to kinematic body
				#Instead of directly setting velocityChar to 0?
				
			
			
			
	4) 	#ROTATE CHAR IWTH CAMERA
	#In ordser to get proper 3d platformer camera rotation,
	#we need to rotate teh character while rotating the camer,a too.
	#Otherwise, Resident-Eveil-style controls in a Mario Odyssey type game!
	#i.e. tilting upwards on joystick will always make your character move northwards,
	#regardless of camera angle.
	#!!!!!!
	var rotate_char_with_camera = -get_parent().get_node("CAMERA_ROOT_SpatialNode/HORIZONTAL_CAM_ROTATE_SpatialNode").global_transform.basis.get_euler().y
	# put a minus in front, or else character moves in wrong directions at certain camera angles
	# Note that we are rotating the node's position.
	# get_euler().y is needed to make it global or something.
	
	var tempJoystickValue = event_position - texture_center
	var tempMovementDirection = tempJoystickValue.rotated(rotate_char_with_camera)
	return tempMovementDirection.normalized()



'
