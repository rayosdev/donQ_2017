#					_Game.gd
extends Node

var player

var _STATE = {
		
				"_CURRENT":null,
				
				"_ROMMING"		:0,
				"_CONVERSATION"	:1,
				"_NOTEBOOK"		:2,
		
			} setget get_state, change_state

signal state_changed(state)

func _ready():
#	connect("state_changed",self,"run_state_changed")
	change_state("_ROMMING")
	
	player = get_tree().get_current_scene().find_node("player")
	if(player == null): print("NO PLAYER FOUND")
	else: print("FOUND PLAYER: %s" %player.get_name())
	

func get_state(): return _STATE._CURRENT


func change_state(state):
	_STATE._CURRENT = state
	print("change_state: @ %s" % _STATE._CURRENT)
	emit_signal("state_changed", _STATE._CURRENT)




func run_state_changed(state):
	print("run_state_changed: @ %s" % state)
	if(_STATE._CURRENT == "_ROMMING")		: print("_ROMMING is running")
	if(_STATE._CURRENT == "_CONVERSATION")	: print("_CONVERSATION is running")
	if(_STATE._CURRENT == "_NOTEBOOK")		: print("_NOTEBOOK is running")


var _Dialog = {

				"Actors"					:[],
				"End_callback_functions"	:[],
				
			#	Example dialog_action
			#[branch,counter]
				['A',1]:{
							'type'				:'Sentens',
							'wait_time'			:1.5,
							'actor'				:0,
							'sentens'			:"Hola",
							'spanish_words'		:{
													'INTERJECTION':{
																	'hola':{
																			'translation'	:{1:'hello',2:'hi'},
																			'is_processed'	:false,
																			'aduio':{
																						'path'		:null,
																						'start_pos'	:null,
																						'end_pod'	:null,
																						'sentese'	:null,
																					},
																			},
																	},
													},
							'callback_function'	:{
													'function_name'				:"end_conversation",
													'function_args'				:[],
													'function_owner'			:0,
													'function_execution_time'	:'start_of_action', # end_of_action
													},
					},
				# test in one line
				['A',2]:{'type':'Sentens',		'wait_time':3,		'actor':1,		'sentens':"Hey muchaco, how's it going?",		'spanish_words':{	'INTERJECTION':{'hola':{	'translation':{1:'hello',2:'hi'},	'is_processed':false,	'aduio':{'path':null,	'start_pos':null,	'end_pod':null, 	'sentese':null,},},},},'callback_function'	:{'function_name'				:"end_conversation",'function_args'				:[],'function_owner'			:0,'function_execution_time'	:'start_of_action', },}
}