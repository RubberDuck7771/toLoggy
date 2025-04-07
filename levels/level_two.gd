extends Node2D
@export var level_start_pos: Node2D #write this, then drag the node to the level_1.gd setting to assign as level start pos 
@onready var heartsContainer =  $Player/Camera2D2/HBoxContainer
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.healthChanged.connect(heartsContainer.updateHearts)
	heartsContainer.setMaxHearts(GlobalVar.maxHealth)
	heartsContainer.updateHearts(GlobalVar.currentHealth)
	$Parkour/MovingPlank/AnimationPlayer.play("UpDown")
	$Parkour/MovingPlank2/AnimationPlayer.play("UpDown")
	$Parkour/Plank9/AnimationPlayer.play("UpDown")
	if(GlobalVar.show_text == true):
		$VIP.show()
	elif(GlobalVar.show_text == false):
		$VIP.hide()
	
	#Intro Animation:
	player.can_control = false
	await get_tree().create_timer(1.5).timeout
	$Lines/Line1.show()
	await get_tree().create_timer(2).timeout
	$Lines/Line1.hide()
	$Lines/Line2.show()
	await get_tree().create_timer(2).timeout
	$Lines/Line2.hide()
	$Lines/Line3.show()
	await get_tree().create_timer(3).timeout
	$Lines/Line3.hide()
	$Lines/Line4.show()
	await get_tree().create_timer(2).timeout
	$Lines/Line4.hide()
	$Lines/Line5.show()
	await get_tree().create_timer(3).timeout
	$Lines/Line5.hide()
	$Lines/Line6.show()
	await get_tree().create_timer(1.5).timeout
	$Lines/Line6.hide()
	$Lines/Line7.show()
	await get_tree().create_timer(1.5).timeout
	$Lines/Line7.hide()
	$Lines/Line8.show()
	await get_tree().create_timer(3).timeout
	$Lines/Line8.hide()
	$Lines/Line9a.show()
	await get_tree().create_timer(0.6).timeout
	$Lines/Line9b.show()
	await get_tree().create_timer(0.8).timeout
	$Lines/Line9a.hide()
	$Lines/Line9b.hide()
	player.can_control = true

func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://levels/final.tscn")
