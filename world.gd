extends Node2D

var EnemyType := {
	none = "none", 
	walker = "walker", 
	runner = "runner", 
	tank = "tank"
}

var mouse_pos: Vector2
var enemy = preload("res://scenes/enemy.tscn")
var enemies: Array[Resource]

var current_spawning = EnemyType.none
@onready var label = $EnemySide/Label

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			spawn_enemy()

func _process(_delta):
	mouse_pos = get_local_mouse_position()
	label.text = (" " + str(current_spawning))

func spawn_enemy():
	var en = preload("res://scenes/enemy.tscn").instantiate()
	en.en_type = current_spawning
	get_node("enemyHolder").add_child(en)
	en.global_position = mouse_pos

func _on_runner_pressed():
	current_spawning = EnemyType.runner

func _on_walker_pressed():
	current_spawning = EnemyType.walker

func _on_tank_pressed():
	current_spawning = EnemyType.tank
