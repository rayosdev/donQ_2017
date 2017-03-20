#				script	player_movement.gd
extends Sprite


var can_move = false
export (PackedScene) var dot 

var move_speed = 5
var move_vector = Vector2()
var destination

export (NodePath) var root_node

var dots = []

func _ready():
	
	if(root_node != null): root_node = get_node(root_node)
	set_fixed_process(true)
	set_process_input(true)
	pass
	
	
func _fixed_process(delta):
	
	move_player()
	pass
	
#	=><
func _input(event):
	
	# sets the destination vector to the mouse position
	if(Input.get_mouse_button_mask() == 1):
		destination = get_tree().get_root().get_mouse_pos()
		
		#destroy old dots
		if(dots.size() >= 1): 
			dots[0].queue_free()
			dots.pop_front()
		
		#make dots
		var inst_dot = dot.instance()
		root_node.add_child(inst_dot)
		inst_dot.set_global_pos(destination)
		
		#store dot for destruction later
		dots.append(inst_dot)
		
		pass
#	if(parant != null): parant.write_to_term("test")


func move_player():
	if(!can_move): return
	
	#reset move_vector so it dosent increas expentional
	move_vector *= 0
	
	# move player tworeds destination 
	
	if(destination != null):
		if(destination.x <= get_pos().x): move_vector += Vector2(-1,0)
		if(destination.x >= get_pos().x): move_vector += Vector2(1,0)
		if(destination.y <= get_pos().y): move_vector += Vector2(0,-1)
		if(destination.y >= get_pos().y): move_vector += Vector2(0,1)
		
		#increas speed
		move_vector *= move_speed
		
		#stabelaize the end movment
		var x = get_pos().x
		var y = get_pos().y
		var dx = destination.x
		var dy = destination.y
		
		if(abs(x - dx) < move_speed): 
			x = dx
			move_vector.x = 0
		if(abs(y - dy) < move_speed): 
			y = dy
			move_vector.y = 0
			
		set_pos(Vector2(x,y))
		set_pos(get_pos() + move_vector)