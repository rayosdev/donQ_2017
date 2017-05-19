#					landlord.gd
extends "res://R_and_D/mvp/actor.gd"

var conversations
var root_node

func _ready():
	
	root_node = get_tree().get_current_scene()
	print(root_node.get_name())
	
	conversations = get_node("conversations")
#	target_positions.append(Vector2(0,200))
#	set_process(true)
	set_process_input(true)
#	_Game.connect("state_changed",self,"state_changed")
	ask_for_rent(-75)


#func _process(delta):pass

func _input(event):
	#	STATE SWITCH - FOR TESTING
	if(Input.is_action_pressed("R") and event.is_echo() == false):
		if(_Game.get_current_state() != "_ROMMING"):
			_Game.change_state("_ROMMING")
	if(Input.is_action_pressed("C") and event.is_echo() == false):
		if(_Game.get_current_state() != "_CONVERSATION"):
			
			conversations.load_dialog(1)
			_Game.change_state("_CONVERSATION")


func end_conversation(args): _Game.change_state("_ROMMING")


func ask_for_rent(rent_sum): pass
	
	_Game.change_singal_player_stat("Money",rent_sum)

