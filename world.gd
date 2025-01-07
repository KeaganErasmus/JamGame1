extends Node2D

var EnemyType := {
	none = "none", 
	walker = "walker", 
	runner = "runner", 
	tank = "tank"
}

var turret_type := {
	none = "none",
	heavy = "heavy",
	small = "small",
	slow = "slow"
}

var mouse_pos: Vector2

var enemy = preload("res://scenes/enemy.tscn")
var current_spawning = EnemyType.none

var turret = preload("res://scenes/turret.tscn")
var current_turret_spawning = turret_type.none

@onready var en_label = $EnemySide/Label
@onready var tur_label = $TurretSide/Label

#func _ready():
	#pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and current_spawning != "none":
			spawn_enemy()
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and current_turret_spawning != "none":
			spawn_turret()

func _process(_delta):
	mouse_pos = get_local_mouse_position()
	en_label.text = ("Enemy: " + str(current_spawning))
	tur_label.text = ("Turret: " + str(current_turret_spawning))

func spawn_enemy():
	var en = preload("res://scenes/enemy.tscn").instantiate()
	en.en_type = current_spawning
	get_node("enemyHolder").add_child(en)
	en.global_position = mouse_pos

func spawn_turret():
	var tur = preload("res://scenes/turret.tscn").instantiate()
	tur.turret_type = current_turret_spawning
	get_node("turretHolder").add_child(tur)
	tur.global_position = mouse_pos

func _on_runner_pressed():
	current_spawning = EnemyType.runner

func _on_walker_pressed():
	current_spawning = EnemyType.walker

func _on_tank_pressed():
	current_spawning = EnemyType.tank

func _on_heavy_pressed():
	current_turret_spawning = turret_type.heavy


func _on_slow_pressed():
	current_turret_spawning = turret_type.slow


func _on_small_pressed():
	current_turret_spawning = turret_type.small
