extends Spatial

export(PackedScene)  var cube
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var cubesnelheid = 50
export var cooldown = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	shoot()
		
func shoot():
	
	var new_cube = cube.instance()
	new_cube.global_transform = $Position3D.global_transform
	#new_cube.snelheid = cubesnelheid
	var scene_root = get_tree().get_root().get_children()[0]
	scene_root.add_child(new_cube)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
