#					landlord.gd
extends "res://R_and_D/mvp/actor.gd"

var conversations

func _ready():
		
	conversations = get_node("conversations")
#	target_positions.append(Vector2(0,200))
#	set_process(true)
	set_process_input(true)
#	_Game.connect("state_changed",self,"state_changed")
	pass


#func _process(delta):pass

func _input(event):
	#	STATE SWITCH - FOR TESTING
	if(Input.is_action_pressed("R") and event.is_echo() == false):
		if(_Game._STATE._CURRENT != "_ROMMING"):
			_Game.change_state("_ROMMING")
	if(Input.is_action_pressed("C") and event.is_echo() == false):
		if(_Game._STATE._CURRENT != "_CONVERSATION"):
			
			conversations.load_dialog(1)
			_Game.change_state("_CONVERSATION")
			
			
			


