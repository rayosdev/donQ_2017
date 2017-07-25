#					notepad_gui.gd
extends Node2D

var has_been_activated_once = false 

onready var close_btn = get_node("close_btn")

func _ready():
	
	#		Start Settings
	hide()
	
		#		conecntions and setup
	_Game.add_to_node_refrnaces(self.get_name(),self)
	self.connect		("visibility_changed",self,"on_visibility_changed")
	close_btn.connect	("pressed",self,"make_inactive")
	
	#		Script Spesifications
	set_process_input(true)


func on_visibility_changed():
	if(is_visible() and has_been_activated_once == false):
		has_been_activated_once = true
		self.disconnect("visibility_changed",self,"on_visibility_changed")


func _input(event):
	if(Input.is_key_pressed(KEY_V) and event.is_echo() == false):
		show()


#				MAKE_GUI_ACTIVE()
func make_active():
	print("try")
	show()
	_Game.change_state("_NOTEBOOK")


func make_inactive():
	print("try2")
	_Game.change_state("_ROMMING")
	hide()