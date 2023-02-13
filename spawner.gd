extends Spatial

onready var timer = $Timer
var can_shoot = true
export(PackedScene)  var cube
onready var wave_timer = $Timer2
export var cubesnelheid = 20
var aantalblokkengespawned = 0


func _ready():
	pass

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
			cubesnelheid = 25
			$Timer.wait_time == 2
			$wavee.text = "wave 2!!!"
		if aantalblokkengespawned == 10:
			cubesnelheid = 30
			$Timer.wait_time == 2.5
			$wavee.text = "wave 3!!!"
		if aantalblokkengespawned == 15:
			cubesnelheid = 35
			$Timer.wait_time == 3
			$wavee.text = "wave 4!!!"
		if aantalblokkengespawned == 20:
			cubesnelheid = 40
			$Timer.wait_time == 3.5
			$wavee.text = "wave 5!!!"
func get_equation():
	
		var first_random_number = randi() % 10
		var second_random_number = randi() % 10
		var equation_counter = randi() % 4
		var rand2 = randi() % 10
		var rand3 = randi() % 10
		
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
	can_shoot = true 
