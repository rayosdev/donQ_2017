#					player.gd
extends "res://R_and_D/mvp/actor.gd"


func _ready():
	set_process(true)
	set_process_input(true)


func _process(delta):pass

func _on_mouse_click_area_button_down():
	if(_Game._STATE._CURRENT != '_ROMMING'): return
	if(target_positions.empty()):
		target_positions.append(get_tree().get_root().get_mouse_pos())
	else:
		target_positions[0] = get_tree().get_root().get_mouse_pos()

