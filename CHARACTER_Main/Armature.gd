extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func turn_CHAR_towards_Npc_FUNCTION(argument_npc_position):
	pass
	print("Now turning character towards NPC during dialogue...")

	var char_position_for_dialogue = global_transform.origin
	char_position_for_dialogue.y = 0
	look_at( 2*(char_position_for_dialogue) - argument_npc_position, Vector3.UP )
