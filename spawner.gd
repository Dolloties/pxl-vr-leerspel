extends Spatial

onready var timer = $Timer
var can_shoot = true
export(PackedScene)  var cube
onready var wave_timer = $Timer2
export var cubesnelheid = 12
var aantalblokkengespawned = 0
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _process(delta):
	shoot()
	
func shoot():
		
	if can_shoot:
		var rand = randi() % 2
		var new_cube = cube.instance()
		aantalblokkengespawned += 1
		new_cube.global_transform = $Position3D.global_transform
		new_cube.snelheid = cubesnelheid
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(new_cube)
		var result = get_equation()
		
		
		new_cube.get_node("formule").text = result[0]
		print(result[0])
		print(result[1])
		if rand == 1:
			new_cube.get_node("cube1/g_b1").text = "wrong"
			new_cube.get_node("cube2/g_b2").text = "right"
			new_cube.get_node("oplossing1").text = result[1]
			new_cube.get_node("oplossing2").text = result[2]
			can_shoot = false
			timer.start()
		else: 
			new_cube.get_node("cube1/g_b1").text = "right"
			new_cube.get_node("cube2/g_b2").text = "wrong"
			new_cube.get_node("oplossing1").text = result[2]
			new_cube.get_node("oplossing2").text = result[1]
			
			can_shoot = false
			timer.start()
		var aantalblokkenvoornieuwewave = 4
		var speeds = [15, 18, 21, 24, 27, 30, 33, 36, 40,40]
		var times = [2, 1.5, 1.2, 1, 0.8, 0.6, 0.6, 0.6, 0.6,0,6]
		var wave_texts = ["round 2!", "round 3!", "round 4!", "half way!", "round 6!!", "round 7!!", "round 8!!", "round 9!!", "final round!!!, u won!!!!!!!"]
		for i in range(10):
			if aantalblokkengespawned == (i + 1) * aantalblokkenvoornieuwewave:
				cubesnelheid = speeds[i]
				$Timer.wait_time = times[i]
				$wavee.text = wave_texts[i]
				break

		# handle case where aantalblokkengespawned is not one of the expected values

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
