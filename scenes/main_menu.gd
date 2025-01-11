extends Node2D

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://scenes/how_to_play_scene.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
