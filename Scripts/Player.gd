extends KinematicBody2D

export var health = 100
export var score = 0
export var margin = 5
export var y_range = 500
export var acceleration = 0.2

# get the dimensions of the window for calculations
onready var VP = get_viewport_rect().size

# make an instance of a bullet
onready var Bullet_G = load("res://Scene/Bullet_G.tscn")


onready var sprite = $Sprite
# variable signals to be emitted
signal health_changed
signal score_changed

func change_health(h):
	health += h
	# broadcast health change internally
	emit_signal("health_changed")
	if health <= 0:
		die()

func change_score(s):
	score += s
	# broadcast score change internally
	emit_signal("score_changed")

func die():
	
	queue_free()
	var End = load("res://Scene/End.tscn")
	get_tree().change_scene("res://Scene/End.tscn")
	
	
# a vector variable to hold x and y coordinates
var velocity = Vector2(0,0)

# on player instantiation, broadcast
# default health 100 and score 0
func _ready():
	emit_signal("health_changed")
	emit_signal("score_changed")

# update player properties every 60 sec
func _physics_process(delta):
	if Input.is_action_pressed("Fire"):
		# create an instance of the bullet
		var b = Bullet_G.instance()
		# set the bullet to the position of the ship
		b.position = position
		# move the bullet forward
		b.position.y -= 25
		# show the bullet onscreen
		get_node("/root/Games/Bullets").fire(b)
	
	if Input.is_action_pressed("Left"):
		
		velocity.x -= acceleration
	if Input.is_action_pressed("Right"):
		velocity.x += acceleration
	if Input.is_action_pressed("Up"):
		velocity.y -= acceleration
	if Input.is_action_pressed("Down"):
		velocity.y += acceleration
		
	# create an invisible wall that the 
	# player cannot pass on the left/right
	if position.x < margin:
		velocity.x = 0
		position.x = margin
	if position.x > VP.x - margin:
		velocity.x = 0
		position.x = VP.x - margin
	if position.y < VP.y - y_range:
		velocity.y = 0;
		position.y = VP.y - y_range
	if position.y > VP.y - margin:
		velocity.y = 0
		position.y = VP.y - margin
	
	var collision = move_and_collide(velocity)
