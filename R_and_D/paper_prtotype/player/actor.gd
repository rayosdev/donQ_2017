#					actor.gd
extends Sprite

#	movment_actor reccives a move patarn array exp: [[0,0],[120,34],[304,0]]
export (NodePath) var movment_actor

func _ready():
	
	#	exampel of the movement_actor move_engine to see if it works
	get_node("movment_actor").move_engine([[0,0],[120,34],[304,0]])
	
	pass
