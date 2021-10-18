extends ClippedCamera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#I tried 
#	var new_dialog = Dialogic.start('001_TEST_Timeline')
#	new_dialog.connect("timeline_end", self, 'switch_to_GAME_CAM_function')


func switch_to_GAME_CAM_function():
	print("Dilaogue ended. Switch cam to platformer cam.")
	make_current()



#Plan for A Newer Game:
	#Use platformer camera to point at NPC or char during dialogue?
		#Why? cuz having a separate dialogue camera for both the npc and character means having to do var new_dialog = DIlaogic.start() more than once, in more than one script.
#		If later, you change a timeline's name 
#		(whether to better organize/make it easier to find among lots of timelines, or by accidnet)
		#then the game's dialouge might break :/
#		3BUT then again, you don't want lots of dialogue code in the character's kinematib cbody or camera node, do you? I dunno.
