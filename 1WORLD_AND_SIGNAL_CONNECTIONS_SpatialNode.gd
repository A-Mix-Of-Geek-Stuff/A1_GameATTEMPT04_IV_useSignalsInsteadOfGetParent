extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


###DIALOGUE CAMERA SWITCHING###
	#Camera points at whoever's talking during dialogue.
onready var camForDIALOGUE_MainCHAR_nodePath = $____CHAR_KinematicBodyNode____/CHARACTER_fromBlender/Armature/DIALOGUE_CameraNode
onready var ARMATUREforDIALOGUE_CHAR_nodePath = $____CHAR_KinematicBodyNode____/CHARACTER_fromBlender/Armature

onready var emitter_NPC01_ONE_ofSignal_nodePath = $NPC01_KinematicBodyNode/DIALOGUE_INDICATOR_Sprite3DNode
onready var emitter_NPC02_TWO_ofSignal_nodePath = $NPC02_TWO_KinematicBodyNode/DIALOGUE_INDICATOR_Sprite3DNode
onready var emitter_NPC03_THREE_ofSignal_nodePath = $NPC03_THREE_KinematicBodyNode/DIALOGUE_INDICATOR_Sprite3DNode

onready var platformerCam_nodePath = $____CHAR_KinematicBodyNode____/CAMERA_ROOT_OrbitCam_SpatialNode/HORIZONTAL_ROTATE_Cam_SpatialNode/VERTICAL_ROTATE_Cam_SpatialNode/ClippedCameraNode_forPLATFORMER

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
###CONNECTING DIALOGUE CAMERA SWITCHING SIGNALS:
	##Armature for dialogu for character
	emitter_NPC01_ONE_ofSignal_nodePath.connect("turn_CHAR_towards_Npc_SIGNAL", ARMATUREforDIALOGUE_CHAR_nodePath, "turn_CHAR_towards_Npc_FUNCTION")
		#^So character will look_at npc during dialogue.
		#(Without this, players might notice the character and npc aren't eve looking at each other while talking).
	
	##NPC01_ONE:
	emitter_NPC01_ONE_ofSignal_nodePath.connect("makeCamCurrent_CHAR", camForDIALOGUE_MainCHAR_nodePath, "CamSwitchTo_WhoeverIsTalking_function"  )
	emitter_NPC01_ONE_ofSignal_nodePath.connect("switchTo_GAME_CAM_signal", platformerCam_nodePath, 'switch_to_GAME_CAM_function')

	##NPC02_TWO:
	emitter_NPC02_TWO_ofSignal_nodePath.connect("makeCamCurrent_CHAR", camForDIALOGUE_MainCHAR_nodePath, "CamSwitchTo_WhoeverIsTalking_function"  )
	emitter_NPC02_TWO_ofSignal_nodePath.connect("switchTo_GAME_CAM_signal", platformerCam_nodePath, 'switch_to_GAME_CAM_function')
	
	##NPC02_THREE:
	emitter_NPC03_THREE_ofSignal_nodePath.connect("makeCamCurrent_CHAR", camForDIALOGUE_MainCHAR_nodePath, "CamSwitchTo_WhoeverIsTalking_function"  )
	emitter_NPC03_THREE_ofSignal_nodePath.connect("switchTo_GAME_CAM_signal", platformerCam_nodePath, 'switch_to_GAME_CAM_function')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
