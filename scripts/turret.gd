extends Node2D

@export var turret_type: String = "none"

var fire_rate: float
var damage: int
var cost: int
var time_to_live: int

var en_dir: int = 0
var en_distance: float = 0
var timer: float = 0
var time_to_death: float = 0

var enemies: Array = []

@onready var name_label: Label = $NameLabel
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var progress_bar: ProgressBar = $ProgressBar

signal enemy_killed(enemy)
signal enemy_stuned(enemy)

func _ready():
	match turret_type:
		"heavy":
			create_heavy()
		"small":
			create_small()
		"slow":
			create_slow()
	name_label.text = str(turret_type)

func _process(delta):
	progress_bar.value -= delta
	ttl(delta)
	var target = find_nearest_enemy()
	
	if target:
		en_distance = position.distance_to(target.position)
		if en_distance <= 300:
			shoot(target, delta)

func ttl(dt):
	time_to_death += dt
	if time_to_death > time_to_live:
		queue_free()
		time_to_death = 0

func find_nearest_enemy() -> Node:
	var closest_enemy = null
	var shortest_distance = INF
	
	for en in enemies:
		if not is_instance_valid(en):
			continue
		var distance = global_position.distance_to(en.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			closest_enemy = en
			
	return closest_enemy

func create_heavy():
	fire_rate = 1
	damage = 4
	cost = 5
	time_to_live = 3
	progress_bar.max_value = time_to_live
	progress_bar.value = time_to_live
	sprite.sprite_frames = preload("res://scenes/heavy_turret_anim.tres")
	sprite.play("idle")
	
	
func create_small():
	fire_rate = 0.5
	damage = 2
	cost = 1
	time_to_live = 5
	progress_bar.max_value = time_to_live
	progress_bar.value = time_to_live
	sprite.sprite_frames = preload("res://scenes/small_turret_anim.tres")
	sprite.play("idle")
	
func create_slow():
	fire_rate = 1
	damage = 0
	cost = 3
	time_to_live = 5
	progress_bar.max_value = time_to_live
	progress_bar.value = time_to_live
	sprite.sprite_frames = preload("res://scenes/slow_turret_anim.tres")
	sprite.play("idle")

func shoot(target, dt):
	timer += dt
	if timer > fire_rate:
		#var target = find_nearest_enemy()
		if target:
			look_at(target.position)
			sprite.play("shoot")
			if !$AudioStreamPlayer.playing:
				$AudioStreamPlayer.play()
			target.take_damage(damage)
			if turret_type == "slow":
				emit_signal("enemy_stuned", target)
			if target.health <= 0:
				emit_signal("enemy_killed", target)
		timer =  0

func set_enemies(en: Array):
	enemies = en
