extends Area2D

var health: int
var speed: int
var damage: int
var hit_rate: int
var is_stuned: bool

var stunned_timer: float = 0
var attack_time: float = 0

var castle: Area2D

@export var en_type: String = "none"
@onready var sprite = $AnimatedSprite2D
@onready var health_bar = $HealthBar

func _ready():
	match en_type:
		"walker":
			create_walker()
		"runner":
			create_runner()
		"tank":
			create_tank()

func _process(delta):
	if !is_stuned:
		position.x += speed * delta
		sprite.play("walk")
	if is_stuned:
		stunned_timer += delta
		if stunned_timer > 1:
			is_stuned = false
			stunned_timer = 0

func create_walker():
	health = 20
	speed = 20
	damage = 5
	is_stuned = false
	health_bar.max_value = health
	health_bar.value = health
	sprite.sprite_frames = preload("res://scenes/walker_anim.tres")
	sprite.play("idle")

func create_runner():
	health = 5
	speed = 50
	damage = 4
	is_stuned = false
	health_bar.max_value = health
	#health_bar.value = health
	$Sprite2D.modulate = "#F46036"

func create_tank():
	health = 20
	speed = 10
	damage = 3
	is_stuned = false
	health_bar.max_value = health
	health_bar.value = health
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
	queue_free()

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()
	health_bar.value = health
