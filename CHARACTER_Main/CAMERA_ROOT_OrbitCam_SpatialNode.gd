extends Spatial


###IMPORTANT!!!
	#MOVE CAM UP A BIT IN 3D WORLD!
		#Or else the camera will clip into oblivion and you can't see where your character is goin.

# Declare member variables here. Examples:
var HORIZONTAL_camRotate = 0
var VERTICAL_camRotate = -30
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#"This ensures that the camera does not collide with the player":
	$HORIZONTAL_ROTATE_Cam_SpatialNode/VERTICAL_ROTATE_Cam_SpatialNode/ClippedCameraNode_forPLATFORMER.add_exception( get_parent() )
	#^I'm not sure how to get rid of this get_parent, since this is how the tutorial did this.
	#Oh well. Prolly no biggy.
	
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	pass
###########ACTUALLY USE THIS WHEN TOUCH CONTROLS ARE READY:
#	if get_parent().get_node("TOUCH_CONTROLS_CanvasLayer/CAMROTATE_TouchScreenButton").is_pressed() and event is InputEventScreenDrag:
#		HORIZONTAL_camRotate += -event.relative.x 
#		VERTICAL_camRotate += -event.relative.y
##########################


func _physics_process(_delta):
	pass
###########ACTUALLY USE THIS WHEN TOUCH CONTROLS ARE READY:
#	$HORIZONTAL_CAM_ROTATE_SpatialNode.rotation_degrees.y = HORIZONTAL_camRotate
#	$HORIZONTAL_CAM_ROTATE_SpatialNode/VERTICAL_CAM_ROTATE_SpatialNode.rotation_degrees.x = VERTICAL_camRotate
##########################
