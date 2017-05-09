#					actor.gd
extends Sprite

signal has_interaction_collided


func _ready():
	
	#	exampel of the movement_actor move_engine to see if it works
#	get_node("movment_actor").move_engine([[0,0],[120,34],[304,0],Vector2(400,400),[800,600],[80,60],[0,600],[800,0],[500,500]])
	
	pass

#	This function is accesed by the interaction_actor and emits a signal that
#	...other nodes like the story_master can use 
func interaction_collsion(interaction_object):
	emit_signal('has_interaction_collided',interaction_object)
	pass

func move_actor(position):
	get_node("movment_actor").set_target_positions(position)