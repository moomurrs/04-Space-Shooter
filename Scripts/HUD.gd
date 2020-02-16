extends Node2D


func _ready():
	pass

# when emitted from Player.gd,
# this function updates the health
func _on_Player_health_changed():
	var h = get_node("/root/Games/Player").health
	# Health label is a child of this Node script,
	# so use "$" to address its children
	$Health.text = "Health: " + str(h)

# when emitted from Player.gd,
# this function updates the score
func _on_Player_score_changed():
	var s = get_node("/root/Games/Player").score
	$Score.text = "Score: " + str(s)
