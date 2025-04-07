extends CharacterBody2D
@onready var player = $Player

var speed = -70.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = false


func _ready():
	var random = [1,2,3].pick_random()
	if(random == 1):
		$AnimationPlayer.play("spawn")
		$AnimationPlayer.play("walk")
	elif(random == 2):
		$AnimationPlayer.play("spawn_2")
		$AnimationPlayer.play("walk_2")
	elif(random == 3):
		$AnimationPlayer.play("spawn_3")
		$AnimationPlayer.play("walk_3")
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if (not $RayCast2D.is_colliding() or not $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding() or $RayCast2D4.is_colliding() ) and is_on_floor(): 
		flip() #enemy flips when reaches edge/wall but not when reaches player
	velocity.x = speed
	move_and_slide()

func flip(): #you can either do this or make a flipped animation, in order to flip your sprite
	facing_right = !facing_right
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

#--------HEALTH & GETTING HURT---------#
@export var maxHealth: int = 2
var currentHealth = maxHealth

func _on_mause_area_body_entered(body):
	if body is player && GlobalVar.player_attacking == true:
		currentHealth = currentHealth - 1
		visible = false #blinks once when hit
		await get_tree().create_timer(0.2).timeout
		visible = true
	if(currentHealth == 0): #enemy dies
		visible = false #blinks twice when dies
		await get_tree().create_timer(0.2).timeout
		visible = true
		speed = 0
		if($AnimationPlayer.current_animation == "walk"):
			$AnimationPlayer.play("spawn")
		elif($AnimationPlayer.current_animation == "walk_2"):
			$AnimationPlayer.play("spawn_2")
		elif($AnimationPlayer.current_animation == "walk_3"):
			$AnimationPlayer.play("spawn_3")
		await get_tree().create_timer(0.8).timeout
		GlobalVar.mausKills = GlobalVar.mausKills + 1
		GlobalVar.mausAlive = false
		queue_free() #removes the node, so the enemy "dies"
