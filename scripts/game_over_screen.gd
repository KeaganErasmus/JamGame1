extends Node2D

var score

func _ready():
	$ScoreLabel.text = ("Score: " + str(score))
	$AudioStreamPlayer2D.play()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
