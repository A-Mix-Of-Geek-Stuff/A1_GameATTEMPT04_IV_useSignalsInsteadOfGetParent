extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#There's two scripts for character movement:
 # The KinematicBody script
 # The touchscreen controls script
#There's also signals being emited from one node to the other
	#So make sure they're connected, especially if you replace a signal.

# MOVEMENT VARIABLES:
var velocityChar = Vector3.ZERO #Start with a zero vector, or else character will drift at game startup.
	#^the game's physics_process function will continously move your character in this vecotr's direction and magnitude.
	#If it's zero, then the characerr won't move.
	#But if the touchscreen joystick's signal changes this vector's value, your character will move.
var horizontal_Velocity = Vector2(velocityChar.x, -velocityChar.z)

var jumpForce =22
	#^The power of yoru character's jump. You can change this to make them jump higher.

var gravity = 9.8*5 #9.8*1 gravity makes jumping too floaty, and yes, I multiplied by delta and still too floaty.
	#^The force that makes your character fall down when in midair.
	#You can increase this to make them fall faster and feel "heavier" (e.g. like Fox in Melee).
	
var STARTUPspeedChar = 10
	#IMPORTANT!!!!:
	#TLDR: use a start speed of 10. Any other value may bug the game.
	#The closer to 0 startup speed is,
		#the buggier it is (at least on phone)   (e.g. looking downards sometimes, sometimes running in the same spot for a couple noticeable frames)
	#startupspeed of 10 lets you take one step forward by tapping joystick,
		#whereas start speed of 0 you don't move forward at all when just tapping joystick.
	#^But 100 will make the character run REALLY FAST REALLY FAR before they even reach SPPEDchar speed.
var SPEEDchar = 15
	#^You cna increase this to make your character run faster.


#ANIMATION TREE VARIABLES:
onready var animTreeNode = $CHARACTER_fromBlender/AnimationTree
###################!!!I'LL PROLLY HAVE TO RENAME STUFF HERE!



#TOUCH CONTROL VARIABLES:
onready var touchControlsNODE = get_node("TOUCH_CONTROLS_CanvasLayer")
	#^Setting up this variable lets us conveniently access the touchscreen node's code.

#ANIMATION VARIABLES:
onready var armature = $CHARACTER_fromBlender/Armature
###################!!!I'LL PROLLY HAVE TO RENAME STUFF HERE!


####DEBUG VARIABLES
	#ANIM DEBUG:
var moveNslide_value
var HORIZONTAL_moveNslide_value = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Note: This kinematicBody script doesn't have an input(event) function.
#But it receives signals from touchscreen nodes that do have an unhandled_input(event) function (basically same thing as an input(event) function..


########!!!NOW ADDING KEYBOARD CONTROLS
#For Gamejams:
func _unhandled_input(event):
	pass

	#I'm assuming Godot Docs' tutorials use reliable keyboard controls:
	#https://docs.godotengine.org/en/stable/tutorials/3d/fps_tutorial/part_one.html
	#ctrl + F "# Walking" 			(without quotes)
	#And that's the code I used			(while adding it to my touch-to-move code).

	#State a temporary horizontal movement vector
	#that'll be used ONLY FOR KEYBOARD!
	var TEMP_KEYBOARD_HORIZONTAL_velocity = Vector2()
		#^NOTES:
		#1) You have to state this var here,
			#just like how the godot docs fps tut does.
			#Cuz if you put this line of code at the top
			#like how you'd normally do for most variables,
			#movement doesn't stop when you stop pressing the keyboard,
			#sometimes there's input lag, yuck.
		#2) Don't try to use the horizontal_Velocity variable that's used elsewhere in this script.
			#Cuz the touch controls code down below keeps reseetting it to 0,0.
			#It's just easier to define and use a temp variable here.
		#Now that we cleared that up... let's begin!

	#If player presses left or A on their keyboard:
	if Input.is_action_pressed("ui_left"):
		#Minus 1 from TEMP_KEYBOARD_HORIZONTAL_velocity:
		TEMP_KEYBOARD_HORIZONTAL_velocity.x -= 1
		#Note: I added WASD to ui_left and others in Project > Project Settings> InputMap

	#If player presses right or D:
	if Input.is_action_pressed("ui_right"):
		#+1 to the temp vel vector:
		TEMP_KEYBOARD_HORIZONTAL_velocity.x += 1

	if Input.is_action_pressed("ui_up"):
		TEMP_KEYBOARD_HORIZONTAL_velocity.y -= 1

	if Input.is_action_pressed("ui_down"):
		TEMP_KEYBOARD_HORIZONTAL_velocity.y += 1
		#^Notes:
		#1) I don't know why, but you gotta MINUS 1 when pressing up,
			# and PLUS 1 when pressing down.
			# It's weird.
			# Maybe Godot just be like that?
		
		#2) do NOT use Input.is_action_JUST_pressed().
			#Cuz then movement can be unresponsive.
			#It's diff from Input.is_action_pressed() <--without "JUST_pressed()".

	#THIS DOENS"T WORK. It won't print.
#	if Input.is_action_pressed("ui_left") == false and Input.is_action_pressed("ui_right") == false and Input.is_action_pressed("ui_up") == false and Input.is_action_pressed("ui_down") == false:
#		print("left right up down on keyboard is not is-action-pressed()")

	#Now we must normalize the temp keyboard horizontal velocity vector before using it for velocityChar.
	#and maybe also * delta, too? I'm getting conflicting advice?
	#Anyways...
	TEMP_KEYBOARD_HORIZONTAL_velocity = TEMP_KEYBOARD_HORIZONTAL_velocity.normalized()
	#So right now, the temp keyboard velocity will have a magnitude (or length) of 1.
	
#	print("temp keyboard velocity:", TEMP_KEYBOARD_HORIZONTAL_velocity)

	#This works here:
	velocityChar.x = TEMP_KEYBOARD_HORIZONTAL_velocity.x * SPEEDchar
	velocityChar.z = TEMP_KEYBOARD_HORIZONTAL_velocity.y * SPEEDchar
	#But if you put this under animation code
	#the character won't stop when you let go of buttons.
	#And I dunno how to fix it.

	#Only do run_animation code when on the ground.
	#Or else characater will probably do running anim in the air while jumping.
#	if is_on_floor(): 
#		#if the temp keyboard veolocity vector is NOT 0,
#		#Which happens if you're pressing any arrow or wasd keys:
#		if TEMP_KEYBOARD_HORIZONTAL_velocity.length() != 0:
#			#If current animation state is idle animation when you should be running:
#			if animTreeNode.playback.get_current_node() == "Idle-loop":
#				#Travel throo animTree to running loop anim:
#				animTreeNode.playback.travel("Run_2_Anim-loop")
#					#^Note: anim state machine will travel through run startup anim in order to get to run LOOP anim.
#
#		if TEMP_KEYBOARD_HORIZONTAL_velocity.length() == 0:
#		###!!!^ BUT SOMETIMES CHARACTER SLIDES WHILE STANDING!
#			#Try checking velocityChar instead of temp keyboard or touch joystick move_vector?
#			print("temp velocity length is zero!")
#			if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop" :
##			if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop" or animTreeNode.playback.get_current_node() == "Run_1_STARTUP" or animTreeNode.playback.get_current_node() == "Run_3_STOP" :
#				animTreeNode.playback.travel("Idle-loop")

#		if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop" or animTreeNode.playback.get_current_node() == "Run_1_STARTUP" :
#			if TEMP_KEYBOARD_HORIZONTAL_velocity.length() == 0:
#				print("temp velocity length is zero!")
#				animTreeNode.playback.travel("Run_2_Anim-loop")
#
#		#If character is starting up their run:
#		if animTreeNode.playback.get_current_node() == "Run_1_STARTUP":
#
#			#Multiply the now-normalized temp keyboard vector by running speed,
#			#and use it for velocityChar's 3d horizontal values:
#			velocityChar.x = TEMP_KEYBOARD_HORIZONTAL_velocity.x * STARTUPspeedChar
#			velocityChar.z = TEMP_KEYBOARD_HORIZONTAL_velocity.y * STARTUPspeedChar
#				#1) 3d vectors use x and Z for horizontal, and not x and y.
#					#Kinda weird if you learned vector math in school at least for me.
#					#But that just how Godot be lol.
#				#2) I haven't added in animation state machines yet,
#					#nor startup speed.
#					#Just using max running speed for now.
#
#
#		#Neat! Keyboard controls easily compatible with touch controls!
#		#(for now...?)
#
#			#Once the character finishes their startup run anim:
#		if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop":
#			#change movement vectors to top running speed:
#	###############!!!I MIGHT HAVE TO RENAME THIS RUN2LOOP ANIM.
#
#			velocityChar.x = TEMP_KEYBOARD_HORIZONTAL_velocity.x * SPEEDchar
#			velocityChar.z = TEMP_KEYBOARD_HORIZONTAL_velocity.y * SPEEDchar
#
#		#To test if the char actaully has a slow startup speed and a fast top speed:
#		#change the startup speed variable to REALLY FAST
#		#And change the top runnign speed to REALLY SLOW.
#		#It's easier to notice a difference when the startup speed is FASTER than the top running speed.
#


#If the TOUCH_CONTROLS_CanvasLayer node emits its use_move_vector signal:
func _on_TOUCH_CONTROLS_CanvasLayer_use_move_vector(move_vector):
######!!!DO I HAVE TO RECONNECT THIS SIGNAL???
	#Then change the velocityChar vector's horizontal numbers:
	
	#If character is starting up their run:
	if animTreeNode.playback.get_current_node() == "Run_1_STARTUP":

		#change movement vectors to startup running speed (slow):
		velocityChar.x = move_vector.x * STARTUPspeedChar
		velocityChar.z = move_vector.y * STARTUPspeedChar

	#Once the character finishes their startup run anim:
	if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop":
		#change movement vectors to top running speed:
###############!!!I MIGHT HAVE TO RENAME THIS RUN2LOOP ANIM.

		velocityChar.x = move_vector.x * SPEEDchar
		velocityChar.z = move_vector.y * SPEEDchar
	#To test if the char actaully has a slow startup speed and a fast top speed:
	#change the startup speed variable to REALLY FAST
	#And change the top runnign speed to REALLY SLOW.
	#It's easier to notice a difference when the startup speed is FASTER than the top running speed.

	
	
	#move_vector is a 2D vector that points in the same direction that the touchscreen joystick is "tilted" towards.
	#SPEEDchar is the character's running speed.




#Everything under this _physics_process function happens once per frame afaik.
#i.e. 60 times every second.
func _physics_process(delta):
	#PRINT DEBUG:
#	print("velocityChar is: ", velocityChar)
#	print("animState:", animTreeNode.playback.get_current_node(), "  |  velChar:", velocityChar, "  |  HORIZ_moveNslide.length():", HORIZONTAL_moveNslide_value.length() )
	#If your character is not on any floor i.e. in mid-air from jumping or falling:
	if not is_on_floor():
		#Make them start falling:
		velocityChar.y -= gravity*delta #So later, I read that you shouldn't multiply move_and_slide by delta. But I already fine-tuned the vertical velocity with *delta here, so...

	#P.S. don't do this:
#	if is_on_floor():
#		velocityChar.y = 0 
		#I thought I needed this,
		#but itll prevent jumps.
#
#	lookAtRunningDirection() #This doesn't fix the new looks-down-at-an-angle-after-taking-one-step bug! Weird.
			#^increasing startup speed to 10 fixes it, tho! =)

	#If the velocityChar vector is NOT (0,0,0)
	#i.e. If you're touching the touchscreen movement-joystick:
	horizontal_Velocity = Vector2(velocityChar.x,velocityChar.z)
	if horizontal_Velocity.length() != 0:
		#^We only use horizontal components of the 3d vector
		#cuz the vertical y-component causes a look_at error.
			#^It doesn't affect gameplay,
			#But it makes it hard to read the debugger.
	
			#CAUSE OF LOOK_AT ERROR:	
			#The error happens if the target is parallel to the up-vector
			#(I have no idea why this is a problem, cuz the game still worked, but that's just the way it is).
			#If you stop moving the char, the target would be (0,1,0)
			#cuz for whatever reason, the y-component was always 1.
			#But (0,1,0) is parallel to the up-vector.
			#So the error would print all over the debugger.
		
		#Make the character's animation armature look in the joystick's direction:
		lookAtRunningDirection()
		#Note: turning off look_at does not improve performance (maybe +1 fps at most).
		#So I don't think the look_at failed error is slowing down the game.


	#And start moving your characater!
	moveNslide_value = move_and_slide(velocityChar, Vector3.UP)
	####################!!!DID I MULTIPLY BY DELTA OR WHATEVER?
		#PS this should NOT be under if horzonital velocity != 0
			#Or else gravity doesn't work while standing still.
			#And jupming straight up is wonky.
			#I dunno why it was under that if-0statement.
		#Vector3.UP is just a vector pointing straight up in 3d.
		#You just need to put it here, or else iunno, character movmeent messes up?
		#Remember: this code is continuously checking if it's true, and running it whenever it's true.

		#Note: putting physics_process code under an if statement doesn't improve fps at all.

	####ANIMATION STATE MACHINE CODE HERE:
		#Why? Cuz I'm trying to fix the sliding_in_idleAnim_bug:
	HORIZONTAL_moveNslide_value.x = moveNslide_value.x
	HORIZONTAL_moveNslide_value.y = moveNslide_value.z
	
	if is_on_floor(): #and animStateMachine != some non_running anim e.g. != stunLock anim:

		#if the temp keyboard veolocity vector is NOT 0,
		#Which happens if you're pressing any arrow or wasd keys:
		if HORIZONTAL_moveNslide_value.length() > 0.001:
			#If current animation state is idle animation when you should be running:
			if animTreeNode.playback.get_current_node() == "Idle-loop":
				#Travel throo animTree to running loop anim:
				animTreeNode.playback.travel("Run_2_Anim-loop")
					#^Note: anim state machine will travel through run startup anim in order to get to run LOOP anim.

		if HORIZONTAL_moveNslide_value.length() <= 0.001:
		###!!!^ BUT SOMETIMES CHARACTER SLIDES WHILE STANDING!
			#Try checking velocityChar instead of temp keyboard or touch joystick move_vector?
#			print("temp velocity length is zero!")
			if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop" :
		#			if animTreeNode.playback.get_current_node() == "Run_2_Anim-loop" or animTreeNode.playback.get_current_node() == "Run_1_STARTUP" or animTreeNode.playback.get_current_node() == "Run_3_STOP" :
				animTreeNode.playback.travel("Idle-loop")


#Signal Function: if you press the jump touchscreen button node:
func _on_JUMP_TouchScreenButton_pressed():
	#And if your character is on the floor:
	if is_on_floor():
		#First reset character's vertical velocity:
		velocityChar.y = 0	#Otherwise, jump height will be inconsistent.
		#Play sound voice:
		$JUMPAudioStreamPlayer3D.play()


		#NOTE: to prevent this sound effect from looping forever,
		#you have to import the sound file in a certain way.
		#Uh... i'm too lazy to explain it righ tnow. lol


		#Then add the jump velocity:
		velocityChar.y += jumpForce
			#^This is the same as writing: velocityChar.y = velocityChar.y + jumpForce
			#In case you're new to Godot.
		# the move_and_slide() method will move the character upwards.


func lookAtRunningDirection():
	armature.look_at(global_transform.origin -Vector3(velocityChar.x, 0, velocityChar.z), Vector3.UP)
	#	#There's a lot of confusing stuff here that I had to figure out for the look_at part, so let me explain:
	#	# 1) we don't wanna use any vertical coordinate for the look_at vector, except 0.
	#		#Otherwise, our character's entire body will awkwardly tilt upwards or downwards.
	#		#That's why the y-coordinated is 0.
	#		#(Reminder: y-coordinate in godot is vertical in 3d, and not z like in math).
	#
	#	# 2) look_at() method works in global coordinates, 
	#	#and there's no local-coordinates alternative afaik.
	#	# So you can't just use the joystick's vector for which direction to look_at.
	#		#Or else the character will take too long to awkwardly turn towards the direction.
	#	# You have to use the character's position (i.e. global_transform.origin)
	#	# And then ADD the joystick vector to get the character to instantly look in that direction.
		#In other words: we need to use complex vector math for look_at to work properly.
	#
	#	#3) Finally, you have to use negative values from the velocityChar vector.
	#		#Otherwise, the charater will look in the opposite direction.
			#Weird, right?
#






