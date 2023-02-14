extends Spatial


export var snelheid = 50
const kill_time = 20
var timer = 0
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * snelheid * delta)
	
	timer += delta
	if timer >= kill_time:
		queue_free()
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	print("i hit something?", body)
	queue_free()
	#check if it was the good or bad one
	

# Replace with function body.


func _on_Area2_body_entered2(body):
	print("i hit something2?", body)
	queue_free()
	 # Replace with function body.
