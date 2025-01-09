extends Area2D

var health: int
var speed: int
var damage: int
var hit_rate: int
var is_alive: bool = true

var attack_time: float = 0
var castle: Area2D

@export var en_type: String = "none"

func _ready():
	match en_type:
		"walker":
			create_walker()
		"runner":
			create_runner()
		"tank":
			create_tank()

func _process(delta):
	position.x += speed * delta

func create_walker():
	health = 20
	speed = 20
	damage = 5
	$Sprite2D.modulate = "#D72638"
	
func create_runner():
	health = 5
	speed = 50
	damage = 4
	$Sprite2D.modulate = "#F46036"

func create_tank():
	health = 20
	speed = 10
	damage = 3
	$Sprite2D.modulate = "#FFD23F"

func do_damage(dt: float):
	attack_time += dt
	if attack_time > hit_rate:
		print("hit")
		attack_time = 0
	pass

func set_castle(thing):
	castle = thing

func die():
	is_alive = false
	queue_free()

func get_damage() -> int:
	return damage

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func get_alive_status() -> bool:
	return is_alive
