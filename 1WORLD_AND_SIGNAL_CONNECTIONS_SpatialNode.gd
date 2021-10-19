extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


###VARS FOR DIALOGUE CAMERA SWITCHING###
#These variables are for making a camera point at whoever's talking during dialogue.
#"Char" refer to the main character you play as.
	#(I prolly shoulda called it "Player" instead of char).
	#NODE PATHS:
onready var camForDIALOGUE_MainCHAR_nodePath = $____CHAR_KinematicBodyNode____/CHARACTER_fromBlender/Armature/DIALOGUE_CameraNode
onready var ARMATUREforDIALOGUE_CHAR_nodePath = $____CHAR_KinematicBodyNode____/CHARACTER_fromBlender/Armature

	#Paths to nodes that emit signals.
	#Each path here comes from a different npc.
	#Add more node-path variables here as you add more Npcs.
onready var emitter_NPC01_ONE_ofSignal_nodePath = $NPC01_KinematicBodyNode/DIALOGUE_INDICATOR_Sprite3DNode
onready var emitter_NPC02_TWO_ofSignal_nodePath = $NPC02_TWO_KinematicBodyNode/DIALOGUE_INDICATOR_Sprite3DNode
onready var emitter_NPC03_THREE_ofSignal_nodePath = $NPC03_THREE_KinematicBodyNode/DIALOGUE_INDICATOR_Sprite3DNode
	#^Note that the node path is for a DIALOGUE_INDICATOR_Sprite3DNode.

	#Node Path for the 3d platformer camera used while running and jumping around:
onready var platformerCam_nodePath = $____CHAR_KinematicBodyNode____/CAMERA_ROOT_OrbitCam_SpatialNode/HORIZONTAL_ROTATE_Cam_SpatialNode/VERTICAL_ROTATE_Cam_SpatialNode/ClippedCameraNode_forPLATFORMER



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
###CONNECTING DIALOGUE CAMERA SWITCHING SIGNALS:
	#Reminder: the emitter_NPC##_###_ofSignal_nodePath's are for DIALOGUE_INDICATOR_Sprite3D nodes.
	#Note: these lines of codes are actually self explanatory.
	#They might look confusing if the long variable names won't fit on a single line.
	
	#E.g. of a signal connection;
	# nodePathForNodeThat_EMITS_a_SIGNAL.connect("NameOfSIGNAL, nodePathForNodeThat_RUNS_THE_DESIRED_FUNCTION, "NameOfFUNCTION").
	#P.s. the function here is in another script on another node.

	##Armature for dialogu for character:
	emitter_NPC01_ONE_ofSignal_nodePath.connect("turn_CHAR_towards_Npc_SIGNAL", ARMATUREforDIALOGUE_CHAR_nodePath, "turn_CHAR_towards_Npc_FUNCTION")
		#^This connects the DIALOGUE_INDICATOR_SPrite3D node for the first npc
		#to the player's spatial node called "Armature" * .
		
		# the turn_CHAR_towards_Npc_FUNCTION is the function that... you guessed it: makes the character turn towards the npc during dialogue
		#(Without this, players might notice the character and npc aren't eve looking at each other while talking).
	
		# * (Note: the "Armature" node in Godot isn't actually the pose bones.
		#(The Skeleton node is the one with the bones).
		#(I dunno why, bu tGodot adds an extra 3d spatial node called "Armature" when importing an asset from Blender.) 
	##NPC01_ONE:
	emitter_NPC01_ONE_ofSignal_nodePath.connect("makeCamCurrent_CHAR", camForDIALOGUE_MainCHAR_nodePath, "CamSwitchTo_WhoeverIsTalking_function"  )
	emitter_NPC01_ONE_ofSignal_nodePath.connect("switchTo_GAME_CAM_signal", platformerCam_nodePath, 'switch_to_GAME_CAM_function')

	##NPC02_TWO:
	emitter_NPC02_TWO_ofSignal_nodePath.connect("makeCamCurrent_CHAR", camForDIALOGUE_MainCHAR_nodePath, "CamSwitchTo_WhoeverIsTalking_function"  )
	emitter_NPC02_TWO_ofSignal_nodePath.connect("switchTo_GAME_CAM_signal", platformerCam_nodePath, 'switch_to_GAME_CAM_function')
	
	##NPC02_THREE:
	emitter_NPC03_THREE_ofSignal_nodePath.connect("makeCamCurrent_CHAR", camForDIALOGUE_MainCHAR_nodePath, "CamSwitchTo_WhoeverIsTalking_function"  )
	emitter_NPC03_THREE_ofSignal_nodePath.connect("switchTo_GAME_CAM_signal", platformerCam_nodePath, 'switch_to_GAME_CAM_function')



#And that's it!
#There's no actual functions in thei script.
#Only connections from signal-emitting nodes to the nodes that run the actual functions.
#I only use this WORLD_SPATIAL node to connect signals
#because sometimes it's better to use a script for a common parent node to connect signals
#(othrewise, you'd have ot use get_parent(), which apparently could cause problems).



