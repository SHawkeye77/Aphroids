extends CharacterBody2D

@onready var reloadTimer = get_node("%ReloadTimer")
@onready var laserBolts = get_tree().get_first_node_in_group("laserBolts")
@onready var world = get_tree().get_first_node_in_group("world")
@onready var laserBolt = preload("res://laser_bolt.tscn")
var endScreen = "res://screens/end_screen.tscn"
var canFire = true

func _ready():
	reloadTimer.wait_time = Global.VOLT_COBRA_RELOAD_TIMER

func _process(delta):
	# Rotational movement
	var xMov = Input.get_action_strength("right") - Input.get_action_strength("left")
	if xMov > 0:
		rotation += Global.VOLT_COBRA_ROTATION_SPEED * delta
	elif xMov < 0:
		rotation -= Global.VOLT_COBRA_ROTATION_SPEED * delta
	
	# Forward movement
	if Input.get_action_strength("up"):
		velocity += Vector2(0, -1.0 * Global.VOLT_COBRA_ACCELERATION).rotated(rotation) * delta
		world.playExhaustAudio()
	else:
		velocity -= velocity * Global.VOLT_COBRA_DECELERATION * delta
		world.stopExhaustAudio()
	
	velocity = velocity.limit_length(Global.VOLT_COBRA_MAX_SPEED)
	move_and_slide()
	
	# Updating the character visually
	set_rotation(rotation)
	
	# Screen wrapping
	if global_position.x > get_viewport_rect().size.x:
		global_position.x = 0
	elif global_position.x < 0:
		global_position.x = get_viewport_rect().size.x
	if global_position.y > get_viewport_rect().size.y:
		global_position.y = 0
	elif global_position.y < 0:
		global_position.y = get_viewport_rect().size.y
	
	# Firing
	if Input.is_action_just_pressed("fire"):
		if canFire:
			fire()

func fire():
	# Firing
	var forward = Vector2(0,-1.0).rotated(rotation).normalized()
	var newLaserBolt = laserBolt.instantiate()
	newLaserBolt.direction = forward
	newLaserBolt.global_position = global_position + forward * Global.SHOT_DISTANCE_FROM_CENTER
	newLaserBolt.look_at(forward)
	laserBolts.call_deferred("add_child", newLaserBolt)
	world.playLaserBoltAudio()
	
	# Setting firing cooldown
	canFire = false
	reloadTimer.start()

func _on_reload_timer_timeout():
	canFire = true

func death():
	# Setting end screen data
	Global.FINAL_SCORE = world.points
	Global.FINAL_TIME = world.timeFormatted
	var _level = get_tree().change_scene_to_file(endScreen)
