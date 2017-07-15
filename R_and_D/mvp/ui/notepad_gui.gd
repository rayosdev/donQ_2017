#					notepad_gui.gd
extends Node2D

var has_been_activated_once = false 

func _ready():
	hide()
	_Game.add_to_node_refrnaces(self.get_name(),self)
	self.connect("visibility_changed",self,"on_visibility_changed")
	
	set_process_input(true)


func on_visibility_changed():
	if(is_visible() and has_been_activated_once == false):
		has_been_activated_once = true
		self.disconnect("visibility_changed",self,"on_visibility_changed")


func _input(event):
	if(Input.is_key_pressed(KEY_V) and event.is_echo() == false):
		show()


#				MAKE_GUI_ACTIVE()
func make_gui_active():
	show()