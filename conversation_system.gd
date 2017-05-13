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


func _input(event):pass


func _process(delta):
	if(is_conversation_runing): run_conversation_step()


func state_changed(state):
	if(state == "_CONVERSATION"):
		start_conversation()


func start_conversation():
	consol.show()
	is_conversation_runing = true
	dialog 	= _Game.get_active_dialog()
	audio 	= _Game.get_active_dialog_audio()
	actors = []
	for i in dialog.Actors: 
		actors.append(root_node.find_node(i))


func end_conversation():
	is_conversation_runing = false
	branch_and_counter = ['A',1]
	_Game.change_state("_ROMMING")
	consol.hide()


func run_conversation_step(): 
	
	is_conversation_step_in_progress = true
	if(wait_for_next_step.get_time_left() > 0): return
	
	history_update()
	
	if(dialog.has(branch_and_counter) == false):
		print("ERROR - conversation_failed ON BRANCH_AND_COUNTER: %s " % str(branch_and_counter)) 
		end_conversation()
		return

	var dialog_step = dialog[branch_and_counter]
#	
	if(dialog_step.type == 'Sentens'):
		var actor = actors[dialog_step.actor]
		
		consol['custom_colors/font_color'] = actor.get_actor_consol_color()
		
		consol.set_text(dialog_step.sentens)
		
		if(dialog_step.has('audio_pos')):
			var audio_pos = dialog_step.audio_pos 
			
			if(dialog.Audio_Enabled == true):
				audio.play(audio_pos.start)
				audio_stop_timer.set_wait_time(audio_pos.stop - audio_pos.start)
				audio_stop_timer.start()
		
		if(dialog_step.has('spanish_words')):
			var spanish_words = dialog_step.spanish_words
			for word in spanish_words: 
				dialog.Spanish_Words[word] = spanish_words[word]
			if(spanish_words.has('SPESCIAL_CASE_WORDS')):
				var special_case_words = spanish_words.SPESCIAL_CASE_WORDS
				for word in spanish_words: 
					dialog.Spanish_Words[word] = special_case_words[word]
					
	print(history)				
	branch_and_counter[1] += 1
	is_conversation_step_in_progress = false
	
	if(dialog_step.has('wait_time')):
		wait_for_next_step.set_wait_time(dialog_step.wait_time)
	else: wait_for_next_step.set_wait_time(standard_wait_time)
	wait_for_next_step.start()


func next_dialog_step(): 
	 wait_for_next_step.stop()

func history_update():
	var bac = branch_and_counter 
	history.push_front(branch_and_counter)
	print("HISTORY ADDED: %s" % str([bac[0],bac[1]]))

func previus_dialog_step():
	if(history.size() <= 0): return
	if(history.size() == 1): 
		branch_and_counter = history[0]
		return
	print("HISTORY POPPING: %s" % str(history[0]))
	history.pop_front()
	branch_and_counter = history[0]
	

func _on_audio_stop_timer_timeout(): audio.stop()
