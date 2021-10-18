tool
	#^Put tool here "so that the script runs in the editor."
	#P.S. you have to close the scene and re-open it for the dialogue to work.

extends Viewport


#INSTRUCTIONS:
	#Set up some nodes in this order:
		#Sprite3D Node (parent) > Viewport Node (child node) > LabelNode or Rich Text label (child of child).
	#Copy and paste this script to a Viewport Node's script.
		#MAKE SURE YOU TYPE tool AT THE TOP!
	#Give the Sprite3D node the viewport node as a TEXTURE:
		#Click the Sprite3D node > Inspector > Sprite3D (1st section) > Texture > Select: NewViewportTexture > Choose the Viewport node.
	#FLIP THE TEXT RIGHT SIDE UP:
		# Click Viewport node > Inspector > Render Target (3rd section) > V Flip ON.
	#OPTINAL: MAKE TEXT ALWAYS FACE CAMERA:
		# Click Sprite3D Node >  Inspector > Flags (4th section*) > Billboard: set to ENABLED.
#			*Not to be confused with the Flags section that might show up underneath the Texture section.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	pass
	#"Make the viewport (node) render a texture the same size as the label":	
	size = $IndicatorForDialogue_LabelNode.rect_size	#Does "size" work even though I didn't define it as a varable because I tpyped tool at the top of this script?
	
