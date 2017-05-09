#					landlord.gd
extends "res://R_and_D/mvp/actor.gd"


func _ready():
	
	set_process(true)
	
	_Game._Dialog.Actors.append(get_node("."))
#	target_positions.append(Vector2(0,200))
	pass
	
func _process(delta):pass