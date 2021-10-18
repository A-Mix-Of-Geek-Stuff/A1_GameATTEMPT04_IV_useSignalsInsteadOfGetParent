extends Sprite3D

### READ NOTES AT BOTTOM ###

export var TIMELINE_fromDialogic = 'NPC_3_THREE_Dialog_TIMELINE'


####CAMERA DIALOGUE PORTRAITS VARIABLES####
signal makeCamCurrent_NPC_signal
signal makeCamCurrent_CHAR
signal switchTo_GAME_CAM_signal
	



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var TouchControls_node = get_parent().get_parent().get_node("CHAR_KinematicBody/TOUCH_CONTROLS_CanvasLayer")



var nearNPC = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	visible = false
#	var dialogicTest = Dialogic.start('002_NPC1_Timeline',false)
#	add_child(dialogicTest)
	var new_dialog = Dialogic.start(TIMELINE_fromDialogic)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _unhandled_input(event):
#	If you press any button, including touch button, that triggers the ui_accept Input Map button:
	if Input.is_action_pressed("ui_accept"):
		#DEBUG:
#		print("You pressed the TOUCH talk button.")
		#And if you're also near the NPC:
		if nearNPC == true:
#			print("You pressed talk button while near the NPC")
			#Turn off nearNPC. Or else pressing talk keeps restarting the dialogue, insrtead of proceeding to the next line of dialogue:
			nearNPC = false

			#These 2 lines activate the Dialogic dialogue:
			var new_dialog = Dialogic.start(TIMELINE_fromDialogic)
			new_dialog.connect("dialogic_signal", self, 'point_CAM_at_NPC_function')
			new_dialog.connect("dialogic_signal", self, 'point_CAM_at_CHAR_function')
			new_dialog.connect("dialogic_signal", self, 'send_signal_to_GAME_CAM')
			add_child(new_dialog)

func point_CAM_at_CHAR_function(argument):
	if argument == 'pointCamAt_CHAR':
#		print("Signal received by Dialogic on CHAR camera")
#		camera_CHAR.set_current(true)
		emit_signal("makeCamCurrent_CHAR")

func point_CAM_at_NPC_function(argument):
	if argument == 'pointCamAt_NPC':
#		camera_THIS_NPC.set_current(true)
		emit_signal("makeCamCurrent_NPC_signal")
#		print("Signal received by Dialogic on NPC camera")

func send_signal_to_GAME_CAM(argument):
	if argument == 'switchTo_GAME_CAM_fromDialogic':
		print('Signal from Dialogic received. emitting another signal to platformer cam')
		emit_signal('switchTo_GAME_CAM_signal')
	
#FIXED Camera Switching during dialogue! 
#SOLUTION: put the Dialogic signal connections and signal function under the script with the area_entered.
	#Note; Putting the signal connections and signal functions under each camera doesn't switch cameras if the dialogue is activated by pressing talk button. Only if the dialog starts up right away did it switch..
	#But when did jumping straight up start bugging?



#If any body entered the NPC's area node:
func _on_Area_DIALOGUE_body_entered(body):
	
	#Problem: You can't talk to NPC again UNLESS you leave them and then go near them again. Tha'ts not how games normally work. And not sure how to fix this.
	pass # Replace with function body.

	#Old method:
#	if body == get_parent().get_parent().get_node("CHAR_KinematicBody"):

	#New method that other tutorials use:
	#If the body that entered the NPC's area_node was the main character:
	if body.name == "____CHAR_KinematicBodyNode____":
	#^tested in older project. Yes it works!
	#^ won't break if the order of nodes changes
	#(wheras get_parent() woudl),
	# but you must use the EXACT name string
	#i.e. if you change the node's name,
	#and this name-change updates in the main scene,
	#it won't work.
	#Ps. using collision layers is MORE CONFUSING THAN YOU THINK!
	#e.g. for a kinematiboc body with collision layer #20, print(body.collision_layer) prints something like 524288.
	#BUT if you select more layers, this number changes!
		#Make the Talk-to-nearby-NPC label appear above the NPC: 
		visible = true
		print("entered body.")
		#Set nearNPC = true. This will be used in an input function:
		nearNPC = true
		#Note: You can't just put an input function here for pressing talk touch button, or any button.
		#It won't work, and I think it's because:
			#this body_entered signal function only happens on the 1st frame your character enters the npc's area node.
			#this function doesn't "stay on" like a light switch.
			#It's only "active" for that first frame.
			#After that, it's "deactivated".
			#so you can't press any input button here,
			#not unless you're frame perfect pressing the button at THE EXACT FRAME.





#If a body LEAVES the NPC's area node:
func _on_Area_DIALOGUE_body_exited(body):
	pass # Replace with function body.
	#If the body that left the NPC's area_node was the main character:
	if body.name == "____CHAR_KinematicBodyNode____":
		#Make the Talk-to-nearby-NPC label above the NPC disappear: 
		print("exited body")
		visible = false
		#Set nearNPC = false. This will prevent talking to NPC until you go near them again:
		nearNPC = false
		












#For organization reasons,
#I'll have this code send signals to the main character's dialogue camera and this npc's dialogue camera.
	#instead of having each of these cameras with their own script that receives the dialogic signals
#Why? Cuz it's easier if both of these dialogic-signal-dialogue-camera scripts are on the same script, as opposed to two separate scripts.

#Try collision masks layers for talking to NPC?
	#WhY? My original script uses a get_parent() to refer to the char's kninematibcbody
	# I could move this part of the script to the char's kinemabicy body,
		#But that'd mean every single npc dialogue in the entire game would be crammed on the character's kinematibc body script.
	#Maybe I can use a signal within the entered_body signal?
	#Or maybe using collision layers would be easwier!
	#Or use AREA_entered instead of body_entered?

#https://www.youtube.com/watch?v=Co1B2Q3RDpA&t=1269s
#^This Dialogic vid that I watched b4 @6:57 showed body.is_in_group.
	#Godot docs didn't!
