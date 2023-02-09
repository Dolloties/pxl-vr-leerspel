extends KinematicBody


func _physics_process(delta):
	var velocity = Vector3(0, 0, 10) # move 10 units per second along the Z axis
	move_and_slide(velocity)




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
