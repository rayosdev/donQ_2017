#					conversation_system.gd
extends Node2D

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


var is_conversation_runing = false


func _ready():
	_Game.add_to_node_refrnaces(self.get_name(),self)
	
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
	
	var string_length = "I'll be expecting you to pay the 75 dineros at the"
#	print("MAX LENGTH OF CONSOL BRFOR NEW LINE: %s" % str(string_length.length()))


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
	if(is_conversation_runing == false): return
#	{check_branch_and_ahdress_for_end}	
	if(history_was_just_roled_back): return
	is_conversation_runing = false
	if(_Game.get_current_state() == "_CONVERSATION"):_Game.change_state("_ROMMING")
#	for key in dialog.Export_Spanish_Word_List.keys():
#		_Words.add_spanish_word(key,dialog.Export_Spanish_Word_List[key])
#	_Utils.ut_fprint_dict(dialog.Export_Spanish_Word_List)
	
	consol.hide()


func run_conversation_step(): 
	
	if(wait_for_next_step.get_time_left() > 0)			: return
	is_conversation_step_in_progress = true
	
	if(late_callback.is_active):
		var lc = late_callback
		send_callback_function_scheduler(lc.actor_calling,lc.func_name,lc.args,lc.wait_time)
		late_callback.is_active = false
	
	history_update()
	
	
	if(_Game.get_current_state() != "_CONVERSATION")	: return  
	
	if(dialog.has(branch_and_counter) == false):
		if(_Game.debug):	print("ERROR - conversation_failed ON BRANCH_AND_COUNTER: %s " % str(branch_and_counter)) 
		end_conversation()
		return

	var dialog_step = dialog[branch_and_counter]
	
	var wait_time
	if(dialog_step.has('wait_time')): 	wait_time = dialog_step.wait_time
	else: 								wait_time = standard_wait_time
		
	var actor = []
	if(dialog_step.has('actor')): actor = actors[dialog_step.actor]
		
	if(dialog_step.has('sentens')):
		consol['custom_colors/font_color'] = actor.get_actor_consol_color()
		
		var sentens = dialog_step.sentens
		sentens = sentens_length_check_and_shortning(sentens)
		consol.set_text(sentens)
	
	
	if(dialog_step.has('audio_pos') and dialog_step.audio_pos != null):
		var audio_pos = dialog_step.audio_pos 
		
		if(dialog.Audio_Enabled == true):
			audio.play(audio_pos.start)
			audio_stop_timer.set_wait_time(audio_pos.stop - audio_pos.start)
			audio_stop_timer.start()
	
	if(dialog_step.has('spanish_words')):
		print("SPANISH WORDS: %s" % str(dialog_step.spanish_words))
		for word in dialog_step.spanish_words:
			_Words.add_spanish_word(word)
#		var spanish_words = dialog_step.spanish_words
#		for word in spanish_words:
#			if(dialog.Spanish_Words.has(word)):
#				print(dialog.Spanish_Words[word])
#				dialog.Export_Spanish_Word_List[word] = dialog.Spanish_Words[word] 
#			else: print("ERROR - DIALOG MISMATCH ON: - %s - AND WORD: - %s - FROM THE CONVERSATION - %s -" %[dialog.Titel,word, dialog_step.sentens])
#			print("EXPORT_WORDS: %s" % str(dialog.Export_Spanish_Word_List))
	
	if(dialog_step.has('callback_functions')):
		var callback_functions	= dialog_step.callback_functions
	
		for func_name in callback_functions:
			var call_func
			if(dialog.Callback_Functions.has(func_name)): 
				call_func = dialog.Callback_Functions[func_name]
			else: print("ERROR - CALLBACK: - %s - COULD NOT BE FOUND IN: - %s -" % [func_name,dialog.Titel])
			
			var owner			= call_func.owner
			var execution_time	= call_func.execution_time
			
			var args = []
			if(call_func.has('args')): args = call_func.args
			else					 : 
				if(_Game.debug):	print("WARNING - NO args IN call_function: %s" % str(call_func))
				
				
			if	(execution_time == "start_of_action"):
				send_callback_function_scheduler(owner,func_name,args,0)
			elif(execution_time == "end_of_action"): 
				send_callback_function_scheduler(owner,func_name,args,wait_time - 0.01)
				
	branch_and_counter[1] += 1
	is_conversation_step_in_progress = false
	wait_for_next_step.set_wait_time(wait_time)
	wait_for_next_step.start()


var history_was_just_roled_back = false

func history_update():
	var bac = branch_and_counter
	var tmp_arr = [str(bac[0]),int(bac[1])] 
	history.push_front(tmp_arr)
	history_was_just_roled_back = false
#	print("HISTORY ADDED: %s" % str(tmp_arr))


func previus_dialog_step():
	if(history.size() <= 0): return
	if(history.size() == 1): return
#	print("HISTORY POPPING: %s" % str(history[0]))
	history.pop_front()
#	print("HISTORY[0]: %s" % str(history[0]))
	branch_and_counter = history[0]
	history_was_just_roled_back = true
	history.pop_front()
	wait_for_next_step.stop()


func next_dialog_step(): wait_for_next_step.stop()


func _on_audio_stop_timer_timeout(): audio.stop()


var late_callback = {
	'is_active'		: false, 
	'actor_calling'	: null,
	'func_name'		: null,
	'args'			: [],
	'wait_time'		: null,
	}

func send_callback_function_scheduler(actor_calling,func_name,args,wait_time):
	
	if(wait_time == 0):
		actors[actor_calling].callback_function(func_name,args)
		late_callback.is_active	= false
	
	if(wait_time > 0):
		late_callback.is_active			= true
		late_callback.actor_calling		= actor_calling
		late_callback.func_name 		= func_name
		late_callback.args				= args
		late_callback.wait_time 		= 0
		


func sentens_length_check_and_shortning(sentens):
	if(sentens.length() > 49):
		var words_in_sentens = []
		var tmp_word_container = ""
		var counter_befor_newline = 0
		for c in sentens:
			counter_befor_newline += 1
			if(counter_befor_newline > 49): 
				words_in_sentens.append("\n")
				counter_befor_newline = 0
			if(c == ' '):
				words_in_sentens.append(tmp_word_container)
				tmp_word_container = ""
			else:
				tmp_word_container += c
		words_in_sentens.append(tmp_word_container)
		sentens = ""
		for w in words_in_sentens:
			if(w == '\n'):	sentens += w
			else: 			sentens += w + " "
#		print(words_in_sentens)
	return sentens
	