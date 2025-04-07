extends Node2D
@export var level_start_pos: Node2D #write this, then drag the node to the level_1.gd setting to assign as level start pos 
@onready var heartsContainer = $Player/Camera2D2/HBoxContainer
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.healthChanged.connect(heartsContainer.updateHearts)
	heartsContainer.setMaxHearts(GlobalVar.maxHealth)
	heartsContainer.updateHearts(GlobalVar.currentHealth)
	#Intro Animation:
	player.can_control = false
	player.hide()
	await get_tree().create_timer(1.5).timeout
	player.show()
	await get_tree().create_timer(1).timeout
	$Line1.show()
	await get_tree().create_timer(5).timeout
	$Line1.hide()
	$Line2.show()
	await get_tree().create_timer(4).timeout
	$Line2.hide()
	$Line3.show()
	await get_tree().create_timer(3).timeout
	$Line3.hide()
	$Line4.show()
	await get_tree().create_timer(5).timeout
	$Line4.hide()
	$Line5.show()
	await get_tree().create_timer(5).timeout
	$Line5.hide()
	$Line6.show()
	await get_tree().create_timer(4).timeout
	$Line6.hide()
	$Line7.show()
	await get_tree().create_timer(4).timeout
	$Line7.hide()
	$Line8.show()
	await get_tree().create_timer(4).timeout
	$Line8.hide()
	$Line9.show()
	await get_tree().create_timer(4).timeout
	$Line9.hide()
	$Line10.show()
	await get_tree().create_timer(4).timeout
	$Line10.hide()
	$Line11.show()
	await get_tree().create_timer(4).timeout
	$Line11.hide()
	player.can_control = true

func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://levels/level_one.tscn")
