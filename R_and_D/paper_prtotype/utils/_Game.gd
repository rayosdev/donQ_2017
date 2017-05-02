#					_Game.gd
extends Node


var _STATE = {
		
				"_CURRENT":null,
				
				"_ROMMING"		:0,
				"_CONVERSATION"	:1,
				"_NOTEBOOK"		:2,
		
			} setget get_state, change_state

signal state_changed(state)

func get_state(): return _STATE._CURRENT


func change_state(state):
	_STATE._CURRENT = state
	print("change_state: @ %s" % _STATE._CURRENT)
	emit_signal("state_changed", _STATE._CURRENT)


func _ready():
	connect("state_changed",self,"run_state_changed")
	change_state("_ROMMING")


func run_state_changed(state):
	print("run_state_changed: @ %s" % state)
	if(_STATE._CURRENT == "_ROMMING")		: print("_ROMMING is running")
	if(_STATE._CURRENT == "_CONVERSATION")	: print("_CONVERSATION is running")
	if(_STATE._CURRENT == "_NOTEBOOK")		: print("_NOTEBOOK is running")


