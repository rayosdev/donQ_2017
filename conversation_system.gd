#					conversation_system.gd
extends Node

var consol
var next_btn
var previus_btn
var wait_for_next_step
var actor_sprites = []

var dialog
var branch_and_counter = ['A',1]

var is_conversation_runing = false


func _ready():
	
	consol 				= get_node("consol")
	next_btn 			= get_node("consol/next")
	previus_btn			= get_node("consol/previus")
	wait_for_next_step 	= get_node("wait_for_next_step")
	actor_sprites.append(get_node("consol/actor_1"))
	actor_sprites.append(get_node("consol/actor_2"))
	
	_Game.connect("state_changed",self,"state_changed")
	
	set_process_input(true)
	set_process(true)


func _input(event):pass


func _process(delta):
	if(is_conversation_runing): run_conversation_step()


func state_changed(state):
	if(state == "_CONVERSATION"):
		start_conversation()


func start_conversation():
	consol.show()
	is_conversation_runing = true
	dialog = _Game._Dialog


func end_conversation():
	is_conversation_runing = false
	branch_and_counter = ['A',1]
	_Game.change_state("_ROMMING")
	consol.hide()


func run_conversation_step(): 

	if(wait_for_next_step.get_time_left() > 0): return
	
	if(dialog.has(branch_and_counter) == false):
		print("ERROR - conversation_failed ON BRANCH_AND_COUNTER: %s " % str(branch_and_counter)) 
		end_conversation()
		return
	
	var dialog_step = dialog[branch_and_counter]
#	print("DIALOG_STEP: %s" % str(dialog_step))
	
	if(dialog_step.type == 'Sentens'):
		var actor = dialog.Actors[dialog_step.actor]
		
		consol['custom_colors/font_color'] = actor.player_consol_color
		consol.set_text(dialog_step.sentens)
		
	
	branch_and_counter[1] += 1
	wait_for_next_step.set_wait_time(dialog_step.wait_time)
	wait_for_next_step.start()
	

#
#			"Actors"					:[],
#			"End_callback_functions"	:[],
#				
#			#	Example dialog_action
#			#[branch,counter]
#				['A',1]:{
#							'type'		:'Sentens',
#							'wait_time'	:0.3,
#							'actor'				:0,
#							'sentens'			:"Hola",
#							'spanish_words'		:['hola'],
#							'callback_function'	:{
#													'function_name'				:"end_conversation",
#													'function_owner'			:0,
#													'function_execution_time'	:'start_of_action'
#													},
#				}