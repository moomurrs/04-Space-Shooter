extends Node2D


func _ready():
	pass

# engine calls this funcion when the explosion sprite is finished
# ths function deletes the explosion
func _on_Sprite_animation_finished():
	queue_free()
