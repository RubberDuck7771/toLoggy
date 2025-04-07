extends Node2D
@export var level_start_pos: Node2D #write this, then drag the node to the level_1.gd setting to assign as level start pos 
@onready var heartsContainer = $Player/Camera2D2/HBoxContainer
@onready var player = $Player
var playedL1 = false
var playedL2 = false
var playedL4 = false
var playedL10 = false

func _ready():
	player.healthChanged.connect(heartsContainer.updateHearts)
	heartsContainer.setMaxHearts(GlobalVar.maxHealth)
	heartsContainer.updateHearts(GlobalVar.currentHealth)
	
func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://levels/level_two.tscn")

#K comments on how dark it is
func _on_trigger_l_1_body_entered(body):
	if body is player && playedL1 == false:
		player.can_control = false
		$Lines/Line1.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line1.hide()
		player.can_control = true
		playedL1 = true

#see goop
func _on_trigger_l_2_body_entered(body):
	if body is player && playedL2 == false:
		player.can_control = false
		$Lines/Line2.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line2.hide()
		$Lines/Line3.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line3.hide()
		$Lines/Line4.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line4.hide()
		player.can_control = true
		playedL2 = true

#see maus
func _on_trigger_l_4_body_entered(body):
	if body is player && playedL4 == false:
		player.can_control = false
		$Parkour/maushold.show()
		$Parkour/maushold/AnimationPlayer2.play("moveIntoScene")
		$Lines/Line5.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line5.hide()
		$Lines/Line6.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line6.hide()
		$Lines/Line7.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line7.hide()
		$Lines/Line8.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line8.hide()
		await get_tree().create_timer(2).timeout
		$Lines/Line9.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line9.hide()
		player.can_control = true
		playedL4 = true

func _on_trigger_l_10_body_entered(body):
	if body is player && playedL10 == false:
		player.can_control = false
		$Lines/Line10.show()
		await get_tree().create_timer(1).timeout
		$Lines/Line10.hide()
		$Lines/Line11.show()
		await get_tree().create_timer(3).timeout
		$GodMaus/AnimationPlayer.play("walk")
		$GodMaus.show()
		$Lines/Line11.hide()
		await get_tree().create_timer(1).timeout
		$Lines/Line12.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line12.hide()
		$Lines/Line13a.show()
		await get_tree().create_timer(0.6).timeout
		$Lines/Line13b.show()
		await get_tree().create_timer(0.8).timeout
		$Lines/Line13a.hide()
		$Lines/Line13b.hide()
		$Lines/Line14.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line14.hide()
		$Lines/Line15.show()
		await get_tree().create_timer(4).timeout
		$Lines/Line15.hide()
		$Lines/Line16.show()
		await get_tree().create_timer(2).timeout
		$Lines/Line16.hide()
		$Lines/Line17.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line17.hide()
		$Lines/Line18.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line18.hide()
		$Lines/Line19.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line19.hide()
		$Lines/Line20.show()
		await get_tree().create_timer(5).timeout
		$Lines/Line20.hide()
		$Lines/Line21.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line21.hide()
		await get_tree().create_timer(1.5).timeout
		$GodMaus.queue_free()
		await get_tree().create_timer(1).timeout
		player.can_control = true
		$"Next Level".show()
		playedL10  = true
