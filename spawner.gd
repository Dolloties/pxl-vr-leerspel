extends Spatial

# Get a reference to the other scene

# Change the text of the label

onready var timer = $Timer
var can_shoot = true
export(PackedScene)  var cube
onready var wave_timer = $Timer2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var cubesnelheid = 10
var aantalblokkengespawned = 0

 # initialize a counter to keep track of the equation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.

func _process(delta):
	shoot()
		
func shoot():
	
	
	
	
		
	if can_shoot:
		var new_cube = cube.instance()
		aantalblokkengespawned += 1
		new_cube.global_transform = $Position3D.global_transform
		new_cube.snelheid = cubesnelheid
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(new_cube)
		
		# change the equation in each new cube
		
		var result = get_equation()
		var rand = randi() % 2
		
		new_cube.get_node("text").text = result[0]
		
		if rand == 1:
			new_cube.get_node("text2").text = result[1]
			new_cube.get_node("text3").text = result[2]
			can_shoot = false
			timer.start()
		else: 
			new_cube.get_node("text2").text = result[2]
			new_cube.get_node("text3").text = result[1]
			
			can_shoot = false
			timer.start()
			
		
		if aantalblokkengespawned == 5:
			cubesnelheid == 30
			$wavee.text = "wave 2!!!"
			
			
		if aantalblokkengespawned == 10:
			cubesnelheid == 40
			
		if aantalblokkengespawned == 15:
			cubesnelheid == 50
			
		if aantalblokkengespawned == 20:
			cubesnelheid = 60
			

# function that returns a different equation each time it's called
func get_equation():
	
		var first_random_number = randi() % 10
		var second_random_number = randi() % 10
		var equation_counter = randi() % 2
		var rand2 = randi() % 10
		var rand3 = randi() % 10
		 # increment the counter each time the function is called
		if equation_counter == 1:
			
			var juistantwoord = first_random_number - second_random_number
			var foutantwoord = juistantwoord - rand2
			if juistantwoord == foutantwoord:
				foutantwoord = foutantwoord - rand3
				return [str(first_random_number)  + "-" + str(second_random_number), str(juistantwoord), str(foutantwoord)]
			else:
				return [str(first_random_number)  + "-" + str(second_random_number), str(juistantwoord), str(foutantwoord)]
			
		else:
			var juistantwoord = first_random_number + second_random_number
			var foutantwoord = juistantwoord + rand2
			if juistantwoord == foutantwoord:
				foutantwoord = foutantwoord - rand3
				return [str(first_random_number)  + "+" + str(second_random_number), str(juistantwoord), str(foutantwoord)]
			else:
				return [str(first_random_number)  + "+" + str(second_random_number), str(juistantwoord), str(foutantwoord)]
		
		




func _on_Timer_timeout():
	
	
	can_shoot = true # Replace with function body.
