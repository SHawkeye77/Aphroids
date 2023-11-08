extends Node2D

@onready var asteroidScene = preload("res://asteroid.tscn")
@onready var world = get_tree().get_first_node_in_group("world")
@onready var asteroids = get_tree().get_first_node_in_group("asteroids")
@onready var despawnTimer = get_node("%DespawnTimer")
var canDespawn = false
var type = -1
var asteroidSpeed = -1
var direction = Vector2(-1, 0)

func _ready():
	despawnTimer.wait_time = Global.ASTEROID_DESPAWN_TIME
	despawnTimer.start()

func _process(delta):
	var velocity = direction.normalized() * asteroidSpeed
	translate(velocity * delta)
	
	# Removing the asteroid if it goes off the screen after the despawn timer is active
	if canDespawn:
		if (global_position.x < 0 or global_position.x > get_viewport_rect().size.x or 
			global_position.y < 0 or global_position.y > get_viewport_rect().size.y):
			self.queue_free()

func _on_despawn_timer_timeout():
	canDespawn = true

func _on_body_entered(body):
	if body.is_in_group("voltCobra"):
		body.death()

func hit():
	if type == 3:
		# Splitting into two type 2 asteroids
		var asteroid1 = asteroidScene.instantiate()
		var asteroid2 = asteroidScene.instantiate()
		asteroid1.global_position = global_position
		asteroid2.global_position = global_position
		asteroid1.direction = direction.rotated(deg_to_rad(-1.0 * Global.ASTEROID_DIVERGENCE_ANGLE / 2))
		asteroid2.direction = direction.rotated(deg_to_rad(Global.ASTEROID_DIVERGENCE_ANGLE / 2))
		asteroid1.type = 2
		asteroid2.type = 2
		asteroid1.asteroidSpeed = Global.ASTEROID_2_SPEED
		asteroid2.asteroidSpeed = Global.ASTEROID_2_SPEED
		asteroid1.scale.x = Global.ASTEROID_2_SCALE
		asteroid2.scale.x = Global.ASTEROID_2_SCALE
		asteroid1.scale.y = Global.ASTEROID_2_SCALE
		asteroid2.scale.y = Global.ASTEROID_2_SCALE
		asteroids.add_child(asteroid1)
		asteroids.add_child(asteroid2)
	elif type == 2:
		# Splitting into two type 1 asteroids
		var asteroid1 = asteroidScene.instantiate()
		var asteroid2 = asteroidScene.instantiate()
		asteroid1.global_position = global_position
		asteroid2.global_position = global_position
		asteroid1.direction = direction.rotated(deg_to_rad(-1.0 * Global.ASTEROID_DIVERGENCE_ANGLE / 2))
		asteroid2.direction = direction.rotated(deg_to_rad(Global.ASTEROID_DIVERGENCE_ANGLE / 2))
		asteroid1.type = 1
		asteroid2.type = 1
		asteroid1.asteroidSpeed = Global.ASTEROID_1_SPEED
		asteroid2.asteroidSpeed = Global.ASTEROID_1_SPEED
		asteroid1.scale.x = Global.ASTEROID_1_SCALE
		asteroid2.scale.x = Global.ASTEROID_1_SCALE
		asteroid1.scale.y = Global.ASTEROID_1_SCALE
		asteroid2.scale.y = Global.ASTEROID_1_SCALE
		asteroids.add_child(asteroid1)
		asteroids.add_child(asteroid2)
	elif type == 1:
		world.getPoints(1)
	queue_free()
	world.playExplosionAudio()
