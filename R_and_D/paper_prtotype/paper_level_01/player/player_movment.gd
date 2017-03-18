extends Sprite

var is_moveable = false

export (NodePath) var parant

func _ready():
	
	if(parant != null): parant = get_node(parant)
	pass
	
#	if(parant != null): parant.write_to_term("test")

