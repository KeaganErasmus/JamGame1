extends Node2D

@export var turret_type: String = "none"
@export var enemies = null

var fire_rate: float
var damage: int

var en_dir = 0
var en_distance = 0
var timer = 0

func _ready():
	match turret_type:
		"heavy":
			create_heavy()
		"small":
			create_small()
		"slow":
			create_slow()
			
func _process(delta):
	for enemy in get_tree().get_nodes_in_group("enemiesGroup"):
		en_dir = position - enemy.position
		#en_distance = distance(position, enemy.position)
		en_distance = position.distance_to(enemy.position)
		if en_distance <= 300:
			look_at(enemy.position)
			shoot(delta)

func create_heavy():
	fire_rate = 1
	damage = 5
	
func create_small():
	fire_rate = 0.2
	damage = 1
	
func create_slow():
	fire_rate = 0.5
	damage = 0

func distance(v1: Vector2, v2: Vector2) -> float:
	var result = sqrt((v1.x - v2.x)*(v1.x - v2.x) + (v1.y - v2.y)*(v1.y - v2.y))
	return result

func shoot(dt):
	timer += dt
	if timer > fire_rate:
		print("shoot: ", turret_type, " ", timer)
		timer =  0