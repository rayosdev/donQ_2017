#					landlord.gd
extends "res://R_and_D/mvp/actor.gd"

var conversations
var root_node
var Interaction_area
var incounters_with_player = 0

func _ready():
	
	root_node = get_tree().get_current_scene()
	
	conversations	 = get_node("conversations")
	Interaction_area = get_node("Interaction_area")
	Interaction_area.connect("area_enter",self,"on_collision_with")
#	target_positions.append(Vector2(0,200))
#	set_process(true)
	set_process_input(true)
	
#	_Game.connect("state_changed",self,"state_changed")

#func _process(delta):	pass


func on_collision_with(area):
	if(area.get_groups().has('player')):
		if(_Game.get_current_state() != "_CONVERSATION"):
			
			if(incounters_with_player == 1): return
			incounters_with_player += 1
			
			conversations.load_dialog(1)
			_Game.change_state("_CONVERSATION")


func _input(event):
	#	STATE SWITCH - FOR TESTING
	if(Input.is_action_pressed("R") and event.is_echo() == false):
		if(_Game.get_current_state() != "_ROMMING"):
			_Game.change_state("_ROMMING")
	if(Input.is_action_pressed("C") and event.is_echo() == false):
		if(_Game.get_current_state() != "_CONVERSATION"):
			conversations.load_dialog(1)
			_Game.change_state("_CONVERSATION")


#					END_CONVERSATION
onready var pause_time_before_movment_starts 		= get_node("conversations/landlord_first_incounter_dialog/pause_time_before_movment_starts")
onready var countdown_for_notepad_reminder 			= get_node("conversations/landlord_first_incounter_dialog/countdown_for_notepad_reminder")

func end_conversation(args): 
	var conversation_system = _Game.get_singel_node_refrence("conversation_system")
	if(typeof(conversation_system) != TYPE_OBJECT): return
	conversation_system.end_conversation()
	
	countdown_for_notepad_reminder.connect("timeout",self,"player_check_notepad_reminder")
	countdown_for_notepad_reminder.start()
	
	pause_time_before_movment_starts.start()
	yield(pause_time_before_movment_starts,'timeout')
	var tmp_arr 		= find_node("exit_path").get_children()
	var end_movement_list 	= []
	for p in tmp_arr: end_movement_list.append( p.get_global_pos())
	set_target_positions(end_movement_list)


func player_check_notepad_reminder():
	var notepad_gui = _Game.get_singel_node_refrence("notepad_gui")
	var reminder	= _Game.get_singel_node_refrence("reminder")
	if(notepad_gui.has_been_activated_once): return
	
	reminder.activate_reminder("I Better check the notepad before I try to find the docs",2,8)


var times_asked_for_rent = 0

func ask_for_rent(args):
	if(args.has('rent_sum') == false): return print("ERROR - FAILD TO FIND 'rent_sum' IN 'args' IN FUNC 'ask_for_rent()' ") 
	var sum = args.rent_sum
	
	var wait_time = Timer.new()
	add_child(wait_time)
	if(args.has('dealay_time') == false): return print("ERROR - FAILD TO FIND 'dealay_time' IN 'args' IN FUNC 'ask_for_rent()' ")
	wait_time.set_wait_time(args.dealay_time)
	wait_time.start()
	yield(wait_time,'timeout')
	
	times_asked_for_rent += 1
	if(times_asked_for_rent > 1): return
	_Game.change_singal_stat("Money",sum)
	wait_time.queue_free()


func activate_notepad(args):
	var node_refrences = _Game.get_node_refrences()
	if(node_refrences.has('notepad_icon') == false): return print('ERROR - NODE_REFRANCE is MISSING OBJ: "notepad" [landlord.gd] ')
	if(node_refrences['notepad_icon'].has('refrence') == false): return print('ERROR - NODE_REFRANCE.NOTEPAD is MISSING: "refrence" [landlord.gd] ')
	var notepad_icon = node_refrences.notepad_icon['refrence']
	print("OK")
	notepad_icon.make_active(true)
	pass




