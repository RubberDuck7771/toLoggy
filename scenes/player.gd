class_name player
extends CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
var checkpointPos = global_position

#-----------------MOVEMENT-----------------#
@export var SPEED = 300.0
const JUMP_VELOCITY = -425.0
var platVel = Vector2(0,0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing = Vector2.RIGHT
func _physics_process(delta):
	if not can_control: return #if you can't control the player (you died), then this function will return nothing
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#--------(GET DIRECTION)---------#
	var direction = Input.get_axis("walk_left","walk_right")
	if Input.is_action_pressed("walk_right"):
		facing = Vector2.RIGHT
	elif Input.is_action_pressed("walk_left"):
		facing = Vector2.LEFT
	if Input.is_action_pressed("idle_front"):
		direction = 0
		animated_sprite_2d.play("idle")
	#--------(WALKING)---------#
	if direction and is_on_floor: 
		velocity.x = direction * SPEED
		if facing == Vector2.RIGHT:
			animated_sprite_2d.play("walk_right")
		elif facing == Vector2.LEFT:
			animated_sprite_2d.play("walk_left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#--------(JUMPING & FALLING)---------#
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.x = platVel.x
		velocity.y = JUMP_VELOCITY
	if (direction == 1) and not is_on_floor():
		animated_sprite_2d.play("walk_right")
	elif direction == -1 and not is_on_floor():
		animated_sprite_2d.play("walk_left")
	#--------(ATTACKING)---------#
	if Input.is_action_pressed("attack") and is_on_floor():
		GlobalVar.player_attacking = true
	if Input.is_action_just_released("attack") and is_on_floor():
		GlobalVar.player_attacking = false
		if facing == Vector2.RIGHT:
			animated_sprite_2d.play("walk_right")
		elif facing == Vector2.LEFT:
			animated_sprite_2d.play("walk_left")
	if GlobalVar.player_attacking == true:
		if facing == Vector2.RIGHT:
			animated_sprite_2d.play("attack_right")
		elif facing == Vector2.LEFT:
			animated_sprite_2d.play("attack_left")
	move_and_slide()
	platVel = get_platform_velocity()

#-----------------HEALTH, TAKING DMG, HEALING-----------------#
#--------(IMMORTALITY)---------#
var immortality_timer: Timer = null
var callImmortality = false
var player_fell = false
@export var immortality: bool = false : set = set_immortality, get = get_immortality
func set_immortality(value: bool):
	immortality = value #turn player immortal for cutscenes/after dmg
func get_immortality() -> bool:
	return immortality #is player immortal, yes or no
func set_temp_immortality(time:float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()

#--------(HEALTH CHANGES)---------#
signal healthChanged
var can_control: bool = true
func handle_danger() -> void: #Getting hit by an enemy or obstacle, makes player blink when hit
	print("Player hit!")
	frameFreeze(0.5, 1.0)
	callImmortality = true
	visible = false
	await get_tree().create_timer(0.1).timeout
	visible = true
	await get_tree().create_timer(0.1).timeout
	visible = false
	await get_tree().create_timer(0.1).timeout
	visible = true
	GlobalVar.currentHealth = GlobalVar.currentHealth - 1
	healthChanged.emit(GlobalVar.currentHealth)
	callImmortality = false
	if GlobalVar.currentHealth == 0:
		await get_tree().create_timer(1).timeout
		GlobalVar.currentHealth = GlobalVar.maxHealth
		player_fell = false
		reset_level()
func handle_void() -> void: #Falling into the void
	print("Player fell!")
	player_fell = true
	handle_danger()
	await get_tree().create_timer(1).timeout
	global_position = checkpointPos
func reset_level() -> void: #Used when fall into void or lose all hearts
	get_tree().reload_current_scene()
	visible = true
	can_control = true
func frameFreeze(timeScale, duration): #stops movement for a fraction of a sec, used to create effect of blinking
	can_control = false
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration*timeScale).timeout
	Engine.time_scale = 1.0
	can_control = true
func heal():
	if(GlobalVar.currentHealth < GlobalVar.maxHealth):
		GlobalVar.currentHealth = GlobalVar.currentHealth + 1
		healthChanged.emit(GlobalVar.currentHealth)
