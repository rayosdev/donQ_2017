#					actor.gd
extends KinematicBody2D

var speed = 5.0

var target_positions = [] setget set_target_positions,get_target_positions

func set_target_positions(array): target_positions = array
func get_target_positions()		: return target_positions
func add_to_target_positions(target_vector):
	print("ADDED TO target_positions VECTOR2: %s" % str(target_vector))
	target_positions.append(target_vector)

func _ready():
	set_fixed_process(true)
#	set_process_input(true)
	set_actor_consol_color(get_node("conversation_color").get_modulate())


var actor_consol_color setget set_actor_consol_color,get_actor_consol_color

func set_actor_consol_color(color):actor_consol_color = color
func get_actor_consol_color(): return actor_consol_color


func run_callback_function(function_name,function_args):
	var call_function = funcref(self,function_name)
	call_function.call_func(function_args)


func _fixed_process(delta):
	if(_Game.get_current_state() == "_ROMMING"):
		if(target_positions != null):
			if(target_positions.empty() == false): 
				move_player()

var echo_shake_check = []

func move_player():
	var direction = Vector2(0,0)
	var gp = get_global_pos()
	var tp = target_positions[0]
	
	
	direction = (tp - gp).normalized() * speed
#	move_to(gp.linear_interpolate(tp,0.05))
#	print(gp.distance_to(tp) < (speed + 1))
	
	if(gp.distance_to(tp) < (speed + 1)):
		move_to(tp)
		target_positions.pop_front()
#		print("POPED THE FRONT")
		return
	
	move(direction)
	
	
#	print("GLOBAL_POS: %s" % get_global_pos())
#	print("TARGET_POS: %s" % target_positions[0])

#	move(direction) #* speed)
	


func test_func(): print("TEST_FUNC: %s" % str(self.get_name()))


func callback_function(func_name,args):
	var callfunc = funcref(self,func_name)
	callfunc.call_func(args)
	
