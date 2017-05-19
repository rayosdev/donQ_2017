#					player.gd
extends "res://R_and_D/mvp/actor.gd"

var camera_refrence
var root_node

func _ready():
	set_process(true)
	set_process_input(true)
	
	root_node 		= get_tree().get_current_scene()
	camera_refrence = root_node.find_node("camera")
	if(camera_refrence == null): print("WARRNING - FAILD TO FIND NODE: 'camera' ON 'player.gd' ")


func _process(delta):pass
	

func _on_mouse_click_area_button_down():
	if(_Game.get_current_state() != '_ROMMING'): return
	if(target_positions.empty()):
		target_positions.append(get_tree().get_root().get_mouse_pos())
	else:
		target_positions[0] = get_tree().get_root().get_mouse_pos()
	print(target_positions)


func camera_follow():pass
	 
