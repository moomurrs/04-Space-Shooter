extends Node2D

export var max_enemies = 5
export var prob = .4

onready var Enemy1 = load("res://Scene/Enemy1.tscn")
onready var Enemy2 = load("res://Scene/Enemy2.tscn")


func _ready():
	pass


func _on_Timer_timeout():
	if get_child_count() < max_enemies + 1:
		if randf() < 0.5 or get_child_count() == 1:
			var e = Enemy1.instance()
			add_child(e)
		else:
			var e = Enemy2.instance()
			add_child(e)
