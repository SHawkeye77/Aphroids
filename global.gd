extends Node

# Volt cobra
const VOLT_COBRA_MAX_SPEED = 500
const VOLT_COBRA_ACCELERATION = 300
const VOLT_COBRA_DECELERATION = 1.5
const VOLT_COBRA_ROTATION_SPEED = 5
const VOLT_COBRA_RELOAD_TIMER = 0.1  # In seconds
const SHOT_DISTANCE_FROM_CENTER = 16

# Laser bolts
const LASER_BOLT_SPEED = 500

# Background 
const SCROLL_SPEED = 40

# Asteroids
const ASTEROID_1_SPEED = 150
const ASTEROID_2_SPEED = 100
const ASTEROID_3_SPEED = 50
const ASTEROID_1_SCALE = 1.0
const ASTEROID_2_SCALE = 2.0
const ASTEROID_3_SCALE = 3.0
const ASTEROID_SPAWN_MARGIN = 50
const ASTEROID_SPAWN_FREQUENCY = 0.3  # In seconds
const ASTEROID_DESPAWN_TIME = 10.0 # In seconds
const ASTEROID_DIVERGENCE_ANGLE = 45.0

# End screen data
var FINAL_SCORE = -1
var FINAL_TIME = ""