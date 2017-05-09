#					actor.gd
extends KinematicBody2D

var target_positions = []
var speed = 5

var player_consol_color


func _ready():
	
	set_process(true)
#	set_process_input(true)
	player_consol_color = get_node("conversation_color").get_modulate()


func run_callback_function(function_name,function_args):
#	print("test_dialog_callback_function")
	var call_function = funcref(self,function_name)
	call_function.call_func(function_args)


func _process(delta):
	
	if(_Game._STATE._CURRENT == "_ROMMING"):
		if(target_positions.empty() == false): move_player()


func move_player():
	
	var is_done = Vector2(0,0)
	var direction = Vector2(0,0)
	
	if(get_global_pos().x > target_positions[0].x): direction.x = -1
	if(get_global_pos().x < target_positions[0].x): direction.x = 1
	
	if(get_pos().y < target_positions[0].y): direction.y = 1
	if(get_pos().y > target_positions[0].y): direction.y = -1
	
	if(get_pos().x > target_positions[0].x - speed and get_pos().x < target_positions[0].x + speed):
		set_pos(Vector2(target_positions[0].x , get_pos().y))
		is_done.x = 1
#		
	if(get_pos().y > target_positions[0].y - speed and get_pos().y < target_positions[0].y + speed):
		set_pos(Vector2(get_pos().x, target_positions[0].y))
		is_done.y = 1
	
	if(is_done.x == 1 and is_done.y == 1):target_positions.pop_front()
	
	move(direction * speed)
	