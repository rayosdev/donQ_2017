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


func end_conversation(args): 
	var conversation_system = root_node.find_node("conversation_system")
	if(conversation_system == null): return print("ERROR - FAILD TO FIND 'conversation_system'")
	
	var wait_timer = Timer.new()
	add_child(wait_timer)
	wait_timer.set_wait_time(0.5)
	wait_timer.start()
	yield(wait_timer,'timeout')
	
	conversation_system.end_conversation()
	var tmp_arr 		= find_node("exit_path").get_children()
	var exit_path_arr 	= []
	for p in tmp_arr: exit_path_arr.append(p.get_global_pos())
	set_target_positions(exit_path_arr)
	wait_timer.queue_free()


var times_executed = 0

func ask_for_rent(args):
	if(args.has('rent_sum') == false): return print("ERROR - FAILD TO FIND 'rent_sum' IN 'args' IN FUNC 'ask_for_rent()' ") 
	var sum = args.rent_sum
	
	var wait_time = Timer.new()
	add_child(wait_time)
	if(args.has('dealay_time') == false): return print("ERROR - FAILD TO FIND 'dealay_time' IN 'args' IN FUNC 'ask_for_rent()' ")
	wait_time.set_wait_time(args.dealay_time)
	wait_time.start()
	yield(wait_time,'timeout')
	
	times_executed += 1
	if(times_executed > 1): return
	_Game.change_singal_stat("Money",sum)
	wait_time.queue_free()


func activate_notepad(args):
	var node_refrences = _Game.get_node_refrences()
	if(node_refrences.has('notepad') == false): return print('ERROR - NODE_REFRANCE is MISSING OBJ: "notepad" [landlord.gd] ')
	if(node_refrences['notepad'].has('refrence') == false): return print('ERROR - NODE_REFRANCE.NOTEPAD is MISSING: "refrence" [landlord.gd] ')
	var notepad = node_refrences.notepad['refrence']
	notepad.make_active(true)
	pass




