extends Node2D

export var prob = 0.2
onready var Meteor = load("res://Scene/Meteor.tscn")
func _ready():
	randomize()
	
	


func _on_Timer_timeout():
	if randf() < prob:
		var m = Meteor.instance()
		add_child(m)
