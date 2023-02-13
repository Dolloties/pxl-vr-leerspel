extends Spatial

onready var timer = $Timer
var can_shoot = true
export(PackedScene)  var cube
onready var wave_timer = $Timer2
export var cubesnelheid = 10
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
			cubesnelheid = 15
			$Timer.wait_time = 4
			$wavee.text = "round 2!!!"
		if aantalblokkengespawned == 10:
			cubesnelheid = 15
			$Timer.wait_time = 3.5
			$wavee.text = "round 3!!!"
		if aantalblokkengespawned == 15:
			cubesnelheid = 20
			$Timer.wait_time = 3.5
			$wavee.text = "round 4!!!"
		if aantalblokkengespawned == 20:
			cubesnelheid = 20
			$Timer.wait_time = 3
			$wavee.text = "round 5!!!"
		if aantalblokkengespawned == 25:
			cubesnelheid = 25
			$Timer.wait_time = 3
			$wavee.text = "round 6!!!"
		if aantalblokkengespawned == 30:
			cubesnelheid = 25
			$Timer.wait_time = 2.5
			$wavee.text = "round 7!!!"
		if aantalblokkengespawned == 35:
			cubesnelheid = 30
			$Timer.wait_time = 2.5
			$wavee.text = "round 8!!!"
		if aantalblokkengespawned == 40:
			cubesnelheid = 30
			$Timer.wait_time = 2
			$wavee.text = "round 9!!!"
			
		if aantalblokkengespawned == 45:
			cubesnelheid = 18
			$Timer.wait_time = 2
			$wavee.text = "final round!!!"
func get_equation():

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var operators = ["+", "-", "*"]
	var first_number = int(rng.randf_range(1, 20))
	var second_number = int(rng.randf_range(1, 20))
	var maalnummer = int(rng.randf_range(1, 5))
	var maalnummer2 = int(rng.randf_range(1, 10))
	var operator = operators[int(rng.randf_range(0, operators.size()))]
	var correct_answer = 0
	if operator == "+":
		correct_answer = first_number + second_number
	elif operator == "-":
		correct_answer = first_number - second_number
	elif operator == "*":
		correct_answer = maalnummer2 * maalnummer
		
	var wrong_answer = int(rng.randf_range(correct_answer - 5, correct_answer + 5))
	while wrong_answer == correct_answer:
		wrong_answer = int(rng.randf_range(correct_answer - 5, correct_answer + 5))
	if operator == "*":
		return [str(maalnummer2) + "*" + str(maalnummer), str(correct_answer), str(wrong_answer)]
	else:
		return [str(first_number) + operator + str(second_number), str(correct_answer), str(wrong_answer)]

func _on_Timer_timeout():
	can_shoot = true 
