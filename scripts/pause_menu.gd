extends CanvasLayer

@onready var resume_button = $PanelContainer/VBoxContainer/Resume
@onready var quit_button = $PanelContainer/VBoxContainer/Quit
@onready var restart_button = $PanelContainer/VBoxContainer/Restart

func _ready():
	resume_button.pressed.connect(self._on_resume_pressed)
	quit_button.pressed.connect(self._on_quit_pressed)
	restart_button.pressed.connect(self._on_restart_pressed)

func _on_resume_pressed():
	get_tree().paused = false
	queue_free()


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
