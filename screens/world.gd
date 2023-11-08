extends Node2D

@onready var pointsLabel = get_node("%PointsLabel")
@onready var timeLabel = get_node("%TimeLabel")
@onready var secondTimer = get_node("%SecondTimer")

# Audio
@onready var exhaustAudio = get_node("%ExhaustAudio")
@onready var laserBoltAudio = get_node("%LaserBoltAudio")
@onready var explosionAudio = get_node("%ExplosionAudio")

var points = -1
var time = -1
var timeFormatted = ""

func _ready():
	points = 0
	time = 0
	secondTimer.start()
	updateGUI()
	# Resetting final score things
	Global.FINAL_SCORE = 0
	Global.FINAL_TIME = ""

func getPoints(pts):
	points += pts
	updateGUI()

func updateGUI():
	# Updating points
	pointsLabel.text = str(points)
	# Updating time
	var mins = int(time/60.0)
	var secs = time % 60
	# Ensuring there's always leading zeros
	if mins < 10:
		mins = str(0, mins)
	if secs < 10:
		secs = str(0, secs)
	timeFormatted = str(mins, ":", secs)
	timeLabel.text = timeFormatted

func _on_second_timer_timeout():
	# Updating the time
	time += 1
	updateGUI()

func playExhaustAudio():
	if not exhaustAudio.is_playing():
		exhaustAudio.play()
		
func stopExhaustAudio():
	if exhaustAudio.is_playing():
		exhaustAudio.stop()
		
func playLaserBoltAudio():
	laserBoltAudio.play()
	
func playExplosionAudio():
	explosionAudio.play()
