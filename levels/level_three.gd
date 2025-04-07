extends Node2D
@export var level_start_pos: Node2D #write this, then drag the node to the level_1.gd setting to assign as level start pos 
@onready var heartsContainer =  $Player/Camera2D2/HBoxContainer
@onready var player = $Player
var mause_scene = preload("res://scenes/maushold.tscn")
var playedL1 = false
var fightOccur = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player.healthChanged.connect(heartsContainer.updateHearts)
	heartsContainer.setMaxHearts(GlobalVar.maxHealth)
	heartsContainer.updateHearts(GlobalVar.currentHealth)
	$GodMaus/AnimationPlayer.play("walk")

#Spawn the mauses when fight is occuring:
var spawn_quantity: float = 1
var spawn_speed: float = 1.0/8.0
func _process(delta):
	while(fightOccur):
		$GodMaus/AnimationPlayer.play("angry")
		await get_tree().create_timer(2).timeout
		spawn_quantity += delta * spawn_speed
		if(spawn_quantity >= 1):
			var spawn_count: float = floor(spawn_quantity)
			spawn_quantity -= spawn_count
			for index in int(spawn_count):
				var mause2 = mause_scene.instantiate()
				mause2.position = Vector2(1860, -820)
		if(GlobalVar.mausKills > 20):
			fightOccur = false
	

func _on_trigger_l_1_body_entered(body):
	if body is player && playedL1 == false:
		player.can_control = false
		$Lines/Line1.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line1.hide()
		$GodMaus/AnimationPlayer.play("angry")
		$Lines/Line2.show()
		await get_tree().create_timer(3).timeout
		$Lines/Line2.hide()
		await get_tree().create_timer(1).timeout
		$GodMaus/AnimationPlayer.play("summon")
		await get_tree().create_timer(1).timeout
		$Parkour/Plank10/CollisionShape2D.queue_free()
		$Parkour/Plank10/Sprite2D.queue_free()
		player.can_control = true
		fightOccur = true
		playedL1 = true


func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://levels/final.tscn")
