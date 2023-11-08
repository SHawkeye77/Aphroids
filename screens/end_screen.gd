extends Control

@onready var scoreLabel = get_node("ScoreLabel")
@onready var timeLabel = get_node("TimeLabel")

var startScreen = "res://screens/start_screen.tscn"

func _ready():
	scoreLabel.text = "Final Score: " + str(Global.FINAL_SCORE)
	timeLabel.text = "Time Alive: " + Global.FINAL_TIME

func _on_main_menu_button_pressed():
	var _level = get_tree().change_scene_to_file(startScreen)
