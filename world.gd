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
var score: int = 0
var timer: float = 0
var resource: int = 50

var enemy: PackedScene = preload("res://scenes/enemy.tscn")
var current_spawning: String = EnemyType.none

var enemies: Array = []
var can_spawn_enemy: bool = false
var killed_by_turret: bool = true

var turret: PackedScene = preload("res://scenes/turret.tscn")
var current_turret_spawning: String = turret_type.none
var can_spawn_turret: bool = false

@onready var en_label: Label = $EnemySide/Label
@onready var tur_label: Label = $TurretSide/Label
@onready var score_label: Label = $ScoreLabel
@onready var resource_label: Label = $ResourceLabel
@onready var castle: Node = $Castle

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and current_spawning != "none" and can_spawn_enemy:
			spawn_enemy()
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and current_turret_spawning != "none" and can_spawn_turret:
			if resource > 0:
				spawn_turret()

func _process(delta):
	mouse_pos = get_global_mouse_position()
	en_label.text = ("Enemy: " + str(current_spawning))
	tur_label.text = ("Turret: " + str(current_turret_spawning))
	score_label.text = ("Score: " + str(score))
	resource_label.text = ("Resource: " + str(resource))
	
	for en in enemies:
		if en.health <= 0:
			remove_enemy(en)
	
	timer += delta
	if timer > 2 and resource < 50:
		resource += 1
		timer = 0
	
	if castle.health <= 0:
		game_lost()

func spawn_enemy():
	var en = preload("res://scenes/enemy.tscn").instantiate()
	en.en_type = current_spawning
	en.add_to_group("enemiesGroup")
	get_node("enemyHolder").add_child(en)
	en.global_position = mouse_pos
	en.set_castle(castle)
	enemies.append(en)

func remove_enemy(en):
	if en in enemies:
		enemies.erase(en)
		en.die()

func spawn_turret():
	var tur = preload("res://scenes/turret.tscn").instantiate()
	tur.turret_type = current_turret_spawning
	tur.set_enemies(enemies)
	get_node("turretHolder").add_child(tur)
	tur.global_position = mouse_pos
	consume_resource(tur.cost)
	tur.connect("enemy_killed", Callable(self, "_on_enemy_killed"))
	tur.connect("enemy_stuned", Callable(self, "_on_enemy_stuned"))

func _on_enemy_killed(en):
	if enemies.has(en):
		enemies.erase(en)
	score += 1

func _on_enemy_stuned(en):
	en.is_stuned = true

func consume_resource(amount: int):
	resource -= amount

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

func _on_enemy_spawn_side_entered():
	can_spawn_enemy = true

func _on_enemy_spawn_side_exited():
	can_spawn_enemy = false

func _on_turret_spawn_side_mouse_entered():
	can_spawn_turret = true

func _on_turret_spawn_side_mouse_exited():
	can_spawn_turret = false

func _on_castle_area_entered(area):
	if area.is_in_group("enemiesGroup"):
		castle.take_damage(area.damage)
		area.health = 0

func game_lost():
	var game_over_screen = preload("res://scenes/game_over_screen.tscn").instantiate()
	game_over_screen.score = score
	get_tree().root.add_child(game_over_screen)
	queue_free()
