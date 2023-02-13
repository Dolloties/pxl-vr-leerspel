extends Spatial

onready var timer = $Timer
var can_shoot = true
export(PackedScene)  var cube
onready var wave_timer = $Timer2
export var cubesnelheid = 20
var aantalblokkengespawned = 0
var rng = RandomNumberGenerator.new()

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
		print(result[0])
		print(result[1])
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

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var operators = ["+", "-", "*"]
	var first_number = int(rng.randf_range(0, 10))
	var second_number = int(rng.randf_range(0, 10))
	var operator = operators[int(rng.randf_range(0, operators.size()))]
	var correct_answer = 0
	if operator == "+":
		correct_answer = first_number + second_number
	elif operator == "-":
		correct_answer = first_number - second_number
	elif operator == "*":
		correct_answer = first_number * second_number
	var wrong_answer = int(rng.randf_range(correct_answer - 5, correct_answer + 5))
	while wrong_answer == correct_answer:
		wrong_answer = int(rng.randf_range(correct_answer - 5, correct_answer + 5))
	return [str(first_number) + operator + str(second_number), str(correct_answer), str(wrong_answer)]

func _on_Timer_timeout():
	can_shoot = true 
