#					conversation_system.gd
extends Node

var dialog = {}

var consol
var next_btn
var previus_btn

var test_txt

func _ready():
	
	consol 		= get_node("consol")
	next_btn 	= get_node("consol/next")
	previus_btn	= get_node("consol/previus")
	
	set_process_input(true)
	
	consol.set_text("test to cosneol")
	
	consol.grab_focus()
	pass


func _input(event):
#	test_txt = consol
	pass
	

	

