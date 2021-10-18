#!1A TO_DO LIST     (ps NOT ACTUALLY A SCRIPT!!!

###CONTROLS    FOR MOVEMENT
	####REMEMBER! USE SIGNALS INSTEAD OF GET_PARENT()! USE $ DOLLAR SIGN INSTEAD OF GET_NODE!

	#Review code		(so i can understand how to put in keyboard controls that's compatible with touch controls)


	#Do the same for jumping.
		#But do running anim first?


####CAMERA

	



###DIALOGUE
	####REMEMBER! USE SIGNALS INSTEAD OF GET_PARENT()! USE $ DOLLAR SIGN INSTEAD OF GET_NODE!

	#Return to platformer cam      after dialogue'

	# disable controls during dialogue.
		#Cuz running in and out of npc's talk range can "duplicate the dialogue"


###ANIMTIONS "hi!"		FOR DIALOGUE
	#Why? To stand out! 			a game with funny animations durign dialogue > a game with only dialogue, no anims.
	
	#Make face anims
	
	#Re-import character with face anims
	
	#Dialogic Signals --> play animation

## FETCH QUEST?
	# Can dialogic do fetch quest stuff?

	# make an object in blender
	
	# import object
	
	# attach object to char's backpack in godot

	# make an inventory windoww/??
		#Kinda too big.
		#Just attach objects to char's backpack
	


###ANIMATIONS Yahho!			FOR MOVEMENT/JUMPING
	####REMEMBER! USE SIGNALS INSTEAD OF GET_PARENT()! USE $ DOLLAR SIGN INSTEAD OF GET_NODE!



	# Jupming anim

	# Make jump sound louder
	# Running SOUNDS






###FIX GAME VIA WEB BROWSER ON ANDROID!
	#Fix touch on itch.io:
		# Try: touching jump button triggers right mouse click.
			#And RMB triggers jump.
	# FIX ANTI-ALIASING FOR BROWSER GAMES
		#Cuz it's pretty bad on itch.io. Not even sure if text will be legible?
		
		
		
# improve fps on Mom's phone!












#!1A TO_DO LIST     (ps NOT ACTUALLY A SCRIPT!!!

###CONTROLS    FOR MOVEMENT
	####REMEMBER! USE SIGNALS INSTEAD OF GET_PARENT()! USE $ DOLLAR SIGN INSTEAD OF GET_NODE!

	#Review code		(so i can understand how to put in keyboard controls that's compatible with touch controls)
			# =) DONE! 					Put in good keyboard controls.
						#I'm assuming Godot Docs uses reliable keyboard controls:
						#https://docs.godotengine.org/en/stable/tutorials/3d/fps_tutorial/part_one.html
						#ctrl + F "# Walking" 			(without quotes)


####CAMERA
	# SKIP: Finish re-adding touch controls code?
		#Why skip? Cuz I wanna upload a playable game on itch.io now!
		# Having a camera that's good enough with working dialog and/or jumping is more important than "re-activating" touch controls fo rnow.
			#Since touch controls don't work on android browser
			#And fixing this would take a while...
	# =) DONE: FIX CLIPPED CAM
		#Why? cuz a normal cam might clip into wall-oblivion
		#SOLUTION: move the clipped cam vertically up in 3d space. That's it! This fixed the cliipping-into-olbivion issue.

	


###ANIMATIONS			FOR MOVEMENT/JUMPING
	####REMEMBER! USE SIGNALS INSTEAD OF GET_PARENT()! USE $ DOLLAR SIGN INSTEAD OF GET_NODE!
	# :) Done?    Running anim
		#SOLUTION: make sure BOTH Animation Node AND Animation TREE node are set to physics process mode.
			#Physics runs at a consistent 60fps, whereas idle runs as fast as possible.


	# Jupming anim
		#FIX SLIDING BUG FIRST
			#Or else the jumping mite just have the same bug
			#And I'll have to fix two sliding bugs instead of 1.
			#SOLUTION?: check if HORIZONTAL_moveNslide != 0
				#instead of KEYBOARD horizonta vel.
				#ALSO! can't use exactly 0, cuz moveNSlide horzionta lenght never equals exaclty 0
				#Yo have to use a deadzone. I used 0.001.
				#I hope this doesn't cause poroblems lateer on tho...
				



###DIALOGUE
	####REMEMBER! USE SIGNALS INSTEAD OF GET_PARENT()! USE $ DOLLAR SIGN INSTEAD OF GET_NODE!
	# =) DONE: 		Install dialogic
	# :) ? Done but still has that relative to "") error.		near_NPC indicator
	# =) DONE:		Dialogic timeline
	# =) DONE THANKS TO EMILIO plugion creator		Fix dialogic parsererror!
			#SOLUTION: Emilio — Today at 7:26 PM
#			if you are using version 1.3
#			[7:26 PM]
#			you don't need the second argument
#
#			AMixOfGeekStuff — Today at 7:29 PM
#			Okay I think it's working now, thanks!
#			And thanks for making this plugin!

	#Talk button on keyboard
	
	#=) DONE. Portrait Cams
		#I started setting up signals			Then got deistrated by ttrying to connect custom signals via editor. But SPrite3d node refuses to do this, even tho other nodes do it.
		#WORKS!!
			#SOLUTION: kidscancode sibling nodes signal connectoin.
			#(? Link was recommended by someone on discord?)
			#Ps i mae a cheat sheet.
	#Return to platformer cam      after dialogue


###ANIMTIONS		FOR DIALOGUE
	#Why? To stand out! 			a game with funny animations durign dialogue > a game with only dialogue, no anims.

	#=) REIGGED FACE ANIM



18_I_wrote_instructions_forAddingNewNPCWithDiffDialogue___


		




