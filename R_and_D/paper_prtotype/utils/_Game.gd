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


var active_dialog = {} setget set_active_dialog,get_active_dialog

func set_active_dialog(dialog): active_dialog = dialog
func get_active_dialog(): return active_dialog
	pass

var active_dialog_audio setget set_active_dialog_audio,get_active_dialog_audio

func set_active_dialog_audio(audio): active_dialog_audio = audio
func get_active_dialog_audio(): return active_dialog_audio
	pass

func _ready():
	player = get_tree().get_current_scene().find_node("player")

#	connect("state_changed",self,"run_state_changed")
	change_state("_ROMMING")
	

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



	