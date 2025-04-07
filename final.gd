extends Node2D
@export var level_start_pos: Node2D #write this, then drag the node to the level_1.gd setting to assign as level start pos 
@onready var heartsContainer =  $Player/Camera2D2/HBoxContainer
@onready var player = $Player
var playedL1 = false
var mausDied = false
var playedL2 = false
var mausAlive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player.healthChanged.connect(heartsContainer.updateHearts)
	heartsContainer.setMaxHearts(GlobalVar.maxHealth)
	heartsContainer.updateHearts(GlobalVar.currentHealth)
	$MovingPlank/AnimationPlayer.play("UpDown")
	$MovingPlank2/AnimationPlayer.play("UpDown")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(mausDied):
		$"Next Level".show()

func _on_trigger_l_1_body_entered(body):
	if body is player && playedL1 == false:
		body.can_control = false
		$Lines/Line1.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line1.hide()
		await get_tree().create_timer(1).timeout
		$GodMaus.queue_free()
		await get_tree().create_timer(1).timeout
		$Decor/PinkBrick5/CollisionShape2D.queue_free()
		$Decor/PinkBrick5/Sprite2D.queue_free()
		$Decor/PinkBrick27/CollisionShape2D.queue_free()
		$Decor/PinkBrick27/Sprite2D.queue_free()
		$Decor/PinkBrick28/CollisionShape2D.queue_free()
		$Decor/PinkBrick28/Sprite2D.queue_free()
		body.can_control = true
		playedL1 = true

func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://end.tscn")

var currentanswer
var answerInputted = false
func _on_trigger_l_2_body_entered(body):
	if body is player && playedL2 == false && GlobalVar.show_text == true:
		$LineEdit.show()
		$Lines/Line2.show()
		await get_tree().create_timer(2.4).timeout
		$Lines/Line2.hide()
		$Lines/Line3.show()
		await get_tree().create_timer(2.4).timeout
		$Lines/Line3.hide()
		await get_tree().create_timer(2).timeout
		#Question 1 --------------------------------
		currentanswer = "04/07"
		while answerInputted == false:
			$Lines/Line4_Q1.show()
			await get_tree().create_timer(1).timeout
			$Lines/Line4.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line4_Q1.hide()
		$Lines/Line4.hide()
		answerInputted = false
		#Question 2 --------------------------------
		currentanswer = "pookie wookie wuggums boo boo bear snuggleufagus hitler mein fuhrer"
		while answerInputted == false:
			$Lines/Line5_Q2.show()
			await get_tree().create_timer(1).timeout
			$Lines/Line5.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line5_Q2.hide()
		$Lines/Line5.hide()
		answerInputted = false
		#Question 3 --------------------------------
		currentanswer = "253 84th st brooklyn ny"
		while answerInputted == false:
			$Lines/Line6_Q3.show()
			await get_tree().create_timer(1).timeout
		await get_tree().create_timer(2).timeout
		$Lines/Line6_Q3.hide()
		answerInputted = false
		#Question 4 --------------------------------
		currentanswer = "avatar the last airbender"
		while answerInputted == false:
			$Lines/Line7_Q4.show()
			await get_tree().create_timer(1).timeout
		await get_tree().create_timer(2).timeout
		$Lines/Line7_Q4.hide()
		answerInputted = false
		#Question 5 --------------------------------
		currentanswer = "fancy rat"
		while answerInputted == false:
			$Lines/Line8_Q5.show()
			await get_tree().create_timer(1).timeout
		await get_tree().create_timer(2).timeout
		$Lines/Line8_Q5.hide()
		answerInputted = false
		#Question 6 --------------------------------
		currentanswer = "flushing"
		while answerInputted == false:
			$Lines/Line9_Q6.show()
			await get_tree().create_timer(1).timeout
			$Lines/Line9.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line9_Q6.hide()
		$Lines/Line9.hide()
		answerInputted = false
		#Question 7 --------------------------------
		currentanswer = "i love i love i love"
		while answerInputted == false:
			$Lines/Line10_Q7.show()
			await get_tree().create_timer(1).timeout
			$Lines/Line10.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line10_Q7.hide()
		$Lines/Line10.hide()
		answerInputted = false
		#Question 8 --------------------------------
		currentanswer = "true"
		while answerInputted == false:
			$Lines/Line11_Q8.show()
			await get_tree().create_timer(1).timeout
			$Lines/Line11.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line11_Q8.hide()
		$Lines/Line11.hide()
		answerInputted = false
		#Question 9 --------------------------------
		currentanswer = "true"
		while answerInputted == false:
			$Lines/Line12_Q9.show()
			await get_tree().create_timer(1).timeout
			$Lines/Line12.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line12_Q9.hide()
		$Lines/Line12.hide()
		answerInputted = false
		#DONE ---------------------------------
		await get_tree().create_timer(2.4).timeout
		$Lines/Line13.show()
		await get_tree().create_timer(2.4).timeout
		$Lines/Line13.hide()
		$Lines/Line14.show()
		await get_tree().create_timer(2.4).timeout
		$Lines/Line14.hide()
		$"Next Level".show()
		player.can_control = true
		playedL2 = true
	elif body is player && playedL2 == false && GlobalVar.show_text == false:
		$Lines/Line15.show()
		await get_tree().create_timer(2.4).timeout
		$Lines/Line15.hide()
		$Decor/PinkBrick25/CollisionShape2D.queue_free()
		$Decor/PinkBrick26/CollisionShape2D.queue_free()
		
var answer
func _input(event):
	if(Input.is_key_pressed(KEY_ENTER)):
		answer = $LineEdit.text.to_lower()
		print(answer)
		answerInputted = true
		if(answer == currentanswer):
			rightAnswer()
		else:
			wrongAnswer()

func wrongAnswer():
	$Lines/WRONG.show()
	await get_tree().create_timer(2.4).timeout
	GlobalVar.currentHealth -= 1
	$Lines/WRONG.hide()

func rightAnswer():
	$Lines/RIGHT.show()
	await get_tree().create_timer(2.4).timeout
	if GlobalVar.currentHealth != GlobalVar.maxHealth:
		GlobalVar.currentHealth += 1
	$Lines/RIGHT.hide()
	
	
