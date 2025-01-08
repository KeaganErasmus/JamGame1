extends Node2D

@export var turret_type: String = "none"

var fire_rate: float
var damage: int
var cost: int
var time_to_live: int

var en_dir = 0
var en_distance = 0
var timer = 0
var time_to_death = 0

var enemies: Array = []

@onready var name_label = $NameLabel

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
	ttl(delta)
	
	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue
		en_distance = position.distance_to(enemy.position)
		if en_distance <= 300:
			look_at(enemy.global_position)
			shoot(delta)

func ttl(dt):
	time_to_death += dt
	if time_to_death > time_to_live:
		queue_free()
		time_to_death = 0

func find_nearest_enemy():
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
	damage = 5
	cost = 5
	time_to_live = 2
	
func create_small():
	fire_rate = 0.5
	damage = 1
	cost = 1
	time_to_live = 5
	
func create_slow():
	fire_rate = 0.5
	damage = 0
	cost = 3
	time_to_live = 5

func shoot(dt):
	timer += dt
	if timer > fire_rate:
		var target = find_nearest_enemy()
		print("shoot: ", turret_type, " ", timer)
		if target:
			target.health -= damage
		timer =  0

func set_enemies(en: Array):
	enemies = en
