extends Node2D


func _ready():
	$Sound.play()
	$Score.text = "Final Score: " + str(GlobalNode.score)
	




