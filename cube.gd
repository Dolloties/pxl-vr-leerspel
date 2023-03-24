extends Spatial

signal punterbij
signal punteraf
var cube1hit = 0
var cube2hit = 0
export var snelheid = 50
const kill_time = 9
var timer = 0
var up = 0
export var height = 0.0
const new_cubejuist = true
var i = 0
var y = 100
export var up_down = true 
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * snelheid * delta)
	if up_down:
		if i < 100:
			var up = global_transform.basis.y.normalized()
			global_translate(up * 1.5 * delta)
			
			i += 1
			if i == 100:
				y = 0
		elif y < 100:
			var up = global_transform.basis.y.normalized()
			global_translate(up * -1.5 * delta)
			
			y += 1
			if y == 100:
				i = 0
	
	
	timer += delta
	if timer >= kill_time:
		if cube1hit == 0 and cube2hit == 0:
			emit_signal("punteraf")
		else:
			cube1hit = 0
			cube2hit = 0
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
	cube1hit = 1
	
	if texty == "right":
		
		emit_signal("punterbij")
	elif texty == "wrong":
		#punt eraf
		emit_signal("punteraf")
	
	$oplossing2.queue_free()
	$cube1.queue_free()
	



	

func _on_Area2_body_entered(body):
	var texty = $cube2/g_b2.get_text()
	cube2hit = 1
	if texty == "right":
		emit_signal("punterbij")
		
	elif texty == "wrong":
		emit_signal("punteraf")
		
	$oplossing1.queue_free()
	$cube2.queue_free()
	
	
	


 # Replace with function body.
