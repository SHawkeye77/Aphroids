extends Node2D

@onready var asteroids = get_tree().get_first_node_in_group("asteroids")
@onready var spawnFrequencyTimer = get_node("%SpawnFrequencyTimer")
@onready var asteroidScene = preload("res://asteroid.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	spawnFrequencyTimer.wait_time = Global.ASTEROID_SPAWN_FREQUENCY
	spawnFrequencyTimer.start()

func _on_timer_timeout():
	var asteroid = asteroidScene.instantiate()
	asteroid.position = getRandomPosition()

	# Point the asteroid towards a random position on the screen
	var randomTargetPosition = Vector2(randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y))
	asteroid.direction = (randomTargetPosition - asteroid.position).normalized()

	# Setting the asteroid type
	var asteroidType = rng.randi_range(0,2)
	if (asteroidType == 0):
		asteroid.type = 1
		asteroid.asteroidSpeed = Global.ASTEROID_1_SPEED
		asteroid.scale.x = Global.ASTEROID_1_SCALE
		asteroid.scale.y = Global.ASTEROID_1_SCALE
	elif (asteroidType == 1):
		asteroid.type = 2
		asteroid.asteroidSpeed = Global.ASTEROID_2_SPEED
		asteroid.scale.x = Global.ASTEROID_2_SCALE
		asteroid.scale.y = Global.ASTEROID_2_SCALE
	elif (asteroidType == 2):
		asteroid.type = 3
		asteroid.asteroidSpeed = Global.ASTEROID_3_SPEED
		asteroid.scale.x = Global.ASTEROID_3_SCALE
		asteroid.scale.y = Global.ASTEROID_3_SCALE
		
	asteroids.add_child(asteroid)

# Returns a random position outside of the player's viewport
func getRandomPosition():
	# Getting a rect a bit bigger than the player's viewport
	var screenDimensions = get_viewport().get_visible_rect().size
	var spawnDimensions = screenDimensions * randf_range(1.1, 1.4)
	
	# Getting the corners of the generated rect
	var topLeft = Vector2(0 - (spawnDimensions.x - screenDimensions.x)/2, 0 - (spawnDimensions.y - screenDimensions.y)/2)
	var topRight = Vector2(screenDimensions.x + (spawnDimensions.x - screenDimensions.x)/2, 0 - (spawnDimensions.y - screenDimensions.y)/2)
	var bottomLeft = Vector2(0 - (spawnDimensions.x - screenDimensions.x)/2, screenDimensions.y + (spawnDimensions.y - screenDimensions.y)/2)
	var bottomRight = Vector2(screenDimensions.x + (spawnDimensions.x - screenDimensions.x)/2, screenDimensions.y + (spawnDimensions.y - screenDimensions.y)/2)
	
	# Picking a random side of the generated rect
	var spawnPos1 = Vector2.ZERO
	var spawnPos2 = Vector2.ZERO
	var posSide = ["up", "down", "right", "left"].pick_random()
	match posSide:
		"up":
			spawnPos1 = topLeft
			spawnPos2 = topRight
		"down":
			spawnPos1 = bottomLeft
			spawnPos2 = bottomRight
		"right":
			spawnPos1 = topRight
			spawnPos2 = bottomRight
		"left":
			spawnPos1 = topLeft
			spawnPos2 = bottomLeft
	
	# Picking a random spot on the random side of the generated rect
	var xSpawn = randf_range(spawnPos1.x, spawnPos2.x)
	var ySpawn = randf_range(spawnPos1.y, spawnPos2.y)
	
	return Vector2(xSpawn, ySpawn)
