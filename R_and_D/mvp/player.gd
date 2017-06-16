#					player.gd
extends "res://R_and_D/mvp/actor.gd"

var root_node

func _ready():
	set_process(true)
	set_process_input(true)
	
	
	root_node 		= get_tree().get_current_scene()
	_Game.connect("state_changed",self,"run_state_changed")

func _process(delta):pass


func run_state_changed(state):
	
	if(state == '_CONVERSATION'): set_target_positions(null)


func _on_mouse_click_area_button_down():
	var mouse_pos = get_global_mouse_pos()
	if(_Game.get_current_state() != '_ROMMING'): return
	set_target_positions([mouse_pos])
