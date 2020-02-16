extends RigidBody2D

var velocity = Vector2(0, 0)
export var min_speed = 100
export var max_speed = 600
export var damage = 50

onready var Explosion = load("res://Scene/Explosion.tscn")

func _ready():
	# create a new random seed
	randomize()
	# position the meteor at a random location at the very top
	position.x = randi() % int(get_viewport_rect().size.x)
	# randomize the meteor velocity
	velocity.y = max(randi() % max_speed, min_speed)
	# keep track of collisions with meteor
	contact_monitor = true
	# only keep track of 4 simultaneous collisions
	set_max_contacts_reported(4)
	linear_velocity = velocity

func _physics_process(delta):
	
	# get a list of bodies that collided with the meteor
	var collisions = get_colliding_bodies()
	# iterate of the list of collisions
	for body in collisions:
		var explosion = Explosion.instance()
		# explosion will happen where the bullet is
		explosion.position = position
		# play the explosion animation
		explosion.get_node("Sprite").playing = true
		# explosion instances will be inside the Explosions container
		get_node("/root/Games/Explosions").add_child(explosion)
		# NOTE: the explosion automatically deletes itself
		# if a meteor collided with the Player, reduce health
		if body.name == "Player":
			body.change_health(-damage)
		queue_free()
	
	# if the meteor is well past the borders, delete it
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _integrate_forces(state):
	# set a constant speed for the meteor
	#state.set_linear_velocity(velocity)
	pass
