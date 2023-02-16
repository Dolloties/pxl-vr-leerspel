extends Spatial

onready var timer = $Timer

var can_shoot = true
export(PackedScene)  var cube

export var cubesnelheid = 10
var aantalblokkengespawned = 0
var rng = RandomNumberGenerator.new()
export var aantalblokkenvoornieuwewave = 5
export var eigenvragen = false
export var maal_aan_of_uit = true

export var min_aan_of_uit = true
export var plus_aan_of_uit = true

export var maalvan = 1
export var maaltot = 3

export var minvan = 1
export var mintot = 20
export var plusvan = 1
export var plustot = 20
var punten = 0
var levens = 5
var game_over = 0
var startklicked = 0
onready var label = $countdownlabel

func on_punterbij():
	
	punten += 1
	
	$punten.text =  "score: " + str(punten)
func on_punteraf():
	
	if levens == 0:
		pass
	else:
		levens -= 1
	$levens.text = "levens: " + str(levens)
	if levens == 0:
		$wavee.text = "game over"
		game_over = 1
		restart_game()
		
func _ready():
	# Set initial label text to 5
	label.text = "10"
	# Start countdown
	countdown()

func _process(delta):
	shoot()
	
func shoot():
		
	if can_shoot and game_over == 0 and startklicked == 1:
		var rand = randi() % 2
		var new_cube = cube.instance()
		aantalblokkengespawned += 1
		new_cube.global_transform = $Position3D.global_transform
		new_cube.snelheid = cubesnelheid    
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(new_cube)
		new_cube.connect("punterbij",self, "on_punterbij")
		new_cube.connect("punteraf",self, "on_punteraf")
		
		
		
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
		
		
		
		var wave_texts = ["round 2!", "round 3!", "round 4!", "round 5!", "round 6!", "round 7!", "round 8!", "round 9!", "round 10!"]
		if aantalblokkengespawned == 10 * aantalblokkenvoornieuwewave:
			can_shoot = false
			$Timer.stop()
			$uwontimer.start()
			$wavee.text = ""
			
		for i in range(10):
			if aantalblokkengespawned == (i + 1) * aantalblokkenvoornieuwewave and aantalblokkengespawned < 10 * aantalblokkenvoornieuwewave :
				cubesnelheid += 2
				$Timer.wait_time -= 0.2
				$wavee.text = wave_texts[i]
				break
	

		# handle case where aantalblokkengespawned is not one of the expected values

func get_equation():
	if eigenvragen == false:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		
		var operators = []
		if maal_aan_of_uit:
			operators.append("*")

		if min_aan_of_uit:
			operators.append("-")
		if plus_aan_of_uit:
			operators.append("+")
			
		
		var plusnummer = int(rng.randf_range(1, 20))
		var plusnummer2 = int(rng.randf_range(plusvan, plustot))
		var minnummer = int(rng.randf_range(1, 20))
		var minnummer2 = int(rng.randf_range(minvan, mintot))
		var maalnummer = int(rng.randf_range(1, 10))
		var maalnummer2 = int(rng.randf_range(maalvan, maaltot))
		
		var operator = operators[int(rng.randf_range(0, operators.size()))]
		var correct_answer = 0.5
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

func countdown():
	var count = int(label.text)
	if count > 1:
		# Subtract 1 from count and update label text
		count -= 1
		label.text = str(count)
		# Wait for 1 second before calling countdown() again
		yield(get_tree().create_timer(1.0), "timeout")
		countdown()
	elif count == 1:
		# Display "start" and wait for 1 second
		label.text = "start"
		startklicked =1
		yield(get_tree().create_timer(1.0), "timeout")
		# Subtract 1 from count and update label text to 0
		
		label.text = ""
		# Wait for 1 second before doing something else
		yield(get_tree().create_timer(1.0), "timeout")
		# Count has reached 0, do something else here
		pass
func restart_game():
	$restart.start()
# Replace with function body.


func _on_restart_timeout():
	pass# Replace with function body.
