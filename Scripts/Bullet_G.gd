extends RigidBody2D


export var speed = 500
onready var Explosion = load("res://Scene/Explosion.tscn")
onready var Player = get_node("/root/Games/Player")


func _ready():
	# bullets do need to have collision detection
	contact_monitor = true
	# bullets may collide many objects simultaneously
	# constrain bullets to only report, at most, 4 simultaneously collisions 
	set_max_contacts_reported(4)
	

func _physics_process(delta):
	# get a list of bodies that collided with bullet
	var collision = get_colliding_bodies()
	
	# play an explosion animation at each collision
	for body in collision:
		# create an explosion instance from a scene
		var explosion = Explosion.instance()
		# explosion will happen where the bullet is
		explosion.position = position
		# play the explosion animation
		explosion.get_node("Sprite").playing = true
		# explosion instances will be inside the Explosions container
		get_node("/root/Games/Explosions").add_child(explosion)
		# NOTE: the explosion automatically deletes itself
		
		
		# check if the bullet hits an enemy body
		# if so, update the player score depending the enemy value
		if body.get_parent().name == "Enemies":
			#print("play sound")
			
			#get_node("Explosion").play(0)
			#$Explosion.play(0)
			Player.change_score(body.score)
			body.die()
		elif body.get_parent().name == "Meteors":
			Player.change_score(5)
			body.die()
		# remove bullet because there is no point in letting it go further
		queue_free()
		
		
	# if player bullet reaches top of screen, delete it
	if position.y < -10:
		queue_free()
# constrain player bullets to only move upwards
# be careful with manually controlling rigibody
# because they are handled by the engine
func _integrate_forces(state):
	state.set_linear_velocity(Vector2(0, -speed))
	state.set_angular_velocity(0)
