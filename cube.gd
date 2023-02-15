extends Spatial

signal punterbij
signal punteraf

export var snelheid = 50
const kill_time = 10
var timer = 0
const new_cubejuist = true
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * snelheid * delta)
	
	timer += delta
	if timer >= kill_time:
		emit_signal("punteraf")
		queue_free()
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	# Do something with the info
# Called when the node enters the scene tree for the first time.
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	 # Replace with function body.
func _on_Area_body_entered(body):
	var texty = $cube1/g_b1.get_text()
	if texty == "right":
		
		emit_signal("punterbij")
	elif texty == "wrong":
		#punt eraf
		emit_signal("punteraf")
	
	$oplossing2.queue_free()
	$cube1.queue_free()



	

func _on_Area2_body_entered(body):
	var texty = $cube2/g_b2.get_text()
	if texty == "right":
		emit_signal("punterbij")
		
	elif texty == "wrong":
		emit_signal("punteraf")
		
	$oplossing1.queue_free()
	$cube2.queue_free()
	
	
	


 # Replace with function body.
