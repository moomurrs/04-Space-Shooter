extends KinematicBody2D

export var limit_y = 350
export var score = 10
export var speed = 2.0
var ready = false

export var move_prob = 0.1
export var fire_prob = 0.3

onready var EnemyBullet = load("res://Scene/EnemyBullet.tscn")

# new location for the enemy
var new_position = Vector2(0, 0)

func get_new_position():
	# get the dimension of the window
	var VP = get_viewport_rect().size
	# produce a new location for the enemy within a predefined area within the screen
	new_position.x = randi() % int(VP.x)
	new_position.y = min(randi() % int(VP.y), int(VP.y - limit_y))
	# when moving to a new location, use this function to make the enemy move in an exponential way
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	# update enemy to the new location
	ready = true

func die():
	queue_free()

# runs at new instance of enemy
func _ready():
	# change random seed
	randomize()
	get_new_position()

# update enemy location
func _physics_process(delta):
	# only move the enemy if it has a new calculated location
	if ready:
		# use the tween to control movement to get an exponential behavior
		$Tween.start()
		# reset the flag to not move the enemy until it has a new location
		ready = false
	

# when the enemy timer runs out, calculate a new position and move
# however, only move based on chance
func _on_Timer_timeout():
	if randf() < move_prob:
		get_new_position()
	
	if randf() < fire_prob:
		var b = EnemyBullet.instance()
		b.position = position
		b.position.y += 25
		get_node("/root/Games/Enemy Bullets").add_child(b)
