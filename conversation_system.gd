#					conversation_system.gd
extends Node

var consol
var next_btn
var previus_btn
var wait_for_next_step
var actor_ui_sprites = []

var root_node

var actors = []
var dialog
var branch_and_counter
var history 							= []
var is_conversation_step_in_progress	= false
var standard_wait_time 					= 5
var audio
var audio_stop_timer

var late_callback = {
	is_active	= false, 
	owner		= null,
	func_name	= null,
	args		= [],
	wait_time	= null,
	}

var is_conversation_runing = false


func _ready():
	
	
	consol 				= get_node("consol")
	next_btn 			= get_node("consol/next")
	previus_btn			= get_node("consol/previus")
	wait_for_next_step 	= get_node("wait_for_next_step")
	audio_stop_timer	= get_node("audio_stop_timer")
	actor_ui_sprites.append(get_node("consol/actor_1"))
	actor_ui_sprites.append(get_node("consol/actor_2"))
	
	
	_Game.connect("state_changed",self,"state_changed")
	
	next_btn.connect	("pressed",self,"next_dialog_step")
	previus_btn.connect	("pressed",self,"previus_dialog_step")
	
	set_process_input(true)
	set_process(true)
	
	root_node = get_tree().get_current_scene().get_node(".")
	
	branch_and_counter = ['A',1] 


func _input(event):
	if(_Game.get_current_state() != "_CONVERSATION"): return
	if(Input.is_action_pressed("ui_right") and event.is_echo() == false):next_dialog_step()
	if(Input.is_action_pressed("ui_left") and event.is_echo() == false):previus_dialog_step()


func _process(delta):
	if(is_conversation_runing): run_conversation_step()


func state_changed(state):
	if(state == "_CONVERSATION"):start_conversation()
	else						:end_conversation()


func start_conversation():
	is_conversation_runing = true
	dialog 	= _Game.get_active_dialog()
	audio 	= _Game.get_active_dialog_audio()
	actors = []
	branch_and_counter = ['A',1]
	history = []
	for i in dialog.Actors: 
		actors.append(root_node.find_node(i))
	consol.set_text("")
	consol.show()


func end_conversation():
	is_conversation_runing = false
	if(_Game.get_current_state() == "_CONVERSATION"):_Game.change_state("_ROMMING")
	consol.hide()


func run_conversation_step(): 
	
	if(wait_for_next_step.get_time_left() > 0)			: return
	is_conversation_step_in_progress = true
	
	if(late_callback.is_active):
		var lc = late_callback
		send_callback_function_scheduler(lc.owner,lc.func_name,lc.args,lc.wait_time)
		late_callback.is_active = false
	
	history_update()
	
	
	if(_Game.get_current_state() != "_CONVERSATION")	: return  
	
	if(dialog.has(branch_and_counter) == false):
		print("ERROR - conversation_failed ON BRANCH_AND_COUNTER: %s " % str(branch_and_counter)) 
		end_conversation()
		return

	var dialog_step = dialog[branch_and_counter]
	
	var wait_time
	if(dialog_step.has('wait_time')): 	wait_time = dialog_step.wait_time
	else: 								wait_time = standard_wait_time
	
	var actor
	if(dialog_step.has('actor')): actor = actors[dialog_step.actor]
	
	if(dialog_step.has('sentens')):
		consol['custom_colors/font_color'] = actor.get_actor_consol_color()
		consol.set_text(dialog_step.sentens)
	
	
	if(dialog_step.has('audio_pos')):
		var audio_pos = dialog_step.audio_pos 
	
		if(dialog.Audio_Enabled == true):
			audio.play(audio_pos.start)
			audio_stop_timer.set_wait_time(audio_pos.stop - audio_pos.start)
			audio_stop_timer.start()
	
	
	if(dialog_step.has('spanish_words')):pass
		var spanish_words = dialog_step.spanish_words
		for word in spanish_words:
			if(dialog.Spanish_Words.has(word)):
				dialog.Export_Spanish_Word_List[word] = dialog.Spanish_Words[word] 
			else: print("ERROR - DIALOG MISMATCH ON: - %s - AND WORD: - %s - FROM THE CONVERSATION - %s -" %[dialog.Titel,word, dialog_step.sentens])
#			print("EXPORT_WORDS: %s" % str(dialog.Export_Spanish_Word_List))
	
	
	if(dialog_step.has('callback_functions')):
		var callback_functions	= dialog_step.callback_functions
	
		for func_name in callback_functions:
			var call_func
			if(dialog.Callback_Functions.has(func_name)): 
				call_func = dialog.Callback_Functions[func_name]
			else: print("ERROR - CALLBACK: - %s - CULD NOT BE FOUND IN: - %s -" % [func_name,dialog.Titel])
	
			var owner			= call_func.owner
			var execution_time	= call_func.execution_time
#				
			var args = []
			if(call_func.has('args')): args = call_func.args
			else					 : print("WARNING - NO args IN call_function: %s" % str(call_func))
			
			if	(execution_time == "start_of_action"):
				send_callback_function_scheduler(owner,func_name,args,0)
			elif(execution_time == "end_of_action"): 
				send_callback_function_scheduler(owner,func_name,args,wait_time - 0.01)
	
	
	branch_and_counter[1] += 1
	is_conversation_step_in_progress = false
	wait_for_next_step.set_wait_time(wait_time)
	wait_for_next_step.start()
	
	


func history_update():
	var bac = branch_and_counter
	var tmp_arr = [str(bac[0]),int(bac[1])] 
	history.push_front(tmp_arr)
#	print("HISTORY ADDED: %s" % str(tmp_arr))


func previus_dialog_step():
	if(history.size() <= 0): return
	if(history.size() == 1): return
#	print("HISTORY POPPING: %s" % str(history[0]))
	history.pop_front()
#	print("HISTORY[0]: %s" % str(history[0]))
	branch_and_counter = history[0]
	history.pop_front()
	wait_for_next_step.stop()
	
	
func next_dialog_step(): 
	 wait_for_next_step.stop()


func _on_audio_stop_timer_timeout(): audio.stop()


func send_callback_function_scheduler(owner,func_name,args,wait_time):
	
	if(wait_time == 0):
		actors[owner].callback_function(func_name,args)
		late_callback.is_active	= false
	
	if(wait_time > 0):
		late_callback.is_active	= true
		late_callback.owner		= owner
		late_callback.func_name = func_name
		late_callback.args		= args
		late_callback.wait_time = 0
