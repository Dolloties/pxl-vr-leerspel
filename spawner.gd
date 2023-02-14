extends Spatial

onready var timer = $Timer
var can_shoot = true
export(PackedScene)  var cube

export var cubesnelheid = 10
var aantalblokkengespawned = 0
var rng = RandomNumberGenerator.new()
export var aantalblokkenvoornieuwewave = 5
export var maalvan = 1
export var maaltot = 5
export var maal_aan_of_uit = true
export var min_aan_of_uit = true
export var plus_aan_of_uit = true
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
		
		var speeds = [12, 13, 14, 15, 16, 17, 18, 19, 20,21]
		var times = [3, 2.8, 2.6, 2.4, 2.2, 2, 1.8, 1.6, 1.4,1.2]
		var wave_texts = ["round 2!", "round 3!", "round 4!", "half way!", "round 6!!", "round 7!!", "round 8!!", "round 9!!", "final round!!!"]
		if aantalblokkengespawned == 10 * aantalblokkenvoornieuwewave:
			can_shoot = false
			$Timer.stop()
			$uwontimer.start()
			$wavee.text = ""
			
		for i in range(10):
			if aantalblokkengespawned == (i + 1) * aantalblokkenvoornieuwewave and aantalblokkengespawned < 10 * aantalblokkenvoornieuwewave :
				cubesnelheid = speeds[i]
				$Timer.wait_time = times[i]
				$wavee.text = wave_texts[i]
				break
	

		# handle case where aantalblokkengespawned is not one of the expected values

func get_equation():
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var operators = ["+", "-", "*"]
	var plusnummer = int(rng.randf_range(1, 20))
	var plusnummer2 = int(rng.randf_range(1, 20))
	var minnummer = int(rng.randf_range(1, 20))
	var minnummer2 = int(rng.randf_range(1, 20))
	var maalnummer = int(rng.randf_range(1, 10))
	var maalnummer2 = int(rng.randf_range(maalvan, maaltot))
	var operator = operators[int(rng.randf_range(0, operators.size()))]
	var correct_answer = 0
	if operator == "+":
		correct_answer = plusnummer + plusnummer2
	elif operator == "-":
		correct_answer = minnummer - minnummer2
	elif operator == "*":
		correct_answer = maalnummer * maalnummer2
		
	var wrong_answer = int(rng.randf_range(correct_answer - 5, correct_answer + 5))
	while wrong_answer == correct_answer:
		wrong_answer = int(rng.randf_range(correct_answer - 5, correct_answer + 5))
	if operator == "*":
		return [str(maalnummer) + operator + str(maalnummer2), str(correct_answer), str(wrong_answer)]
	elif operator == "+":
		return [str(plusnummer) + operator + str(plusnummer2), str(correct_answer), str(wrong_answer)]
	elif operator == "-":
		return [str(minnummer) + operator + str(minnummer2), str(correct_answer), str(wrong_answer)]

func _on_Timer_timeout():
	can_shoot = true 


func _on_uwontimer_timeout():
	$wavee.text = "u won!!!" # Replace with function body.
