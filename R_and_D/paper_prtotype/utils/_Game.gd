#					_Game.gd
extends Node

var player

signal state_changed(state)

var _STATE = {
		
	_CURRENT		= null,
	
	_ROMMING		= 0,
	_CONVERSATION	= 1,
	_NOTEBOOK		= 2,
	
} setget get_state, change_state



var active_dialog = {} setget set_active_dialog,get_active_dialog

func set_active_dialog(dialog): active_dialog = dialog
func get_active_dialog(): return active_dialog


var active_dialog_audio setget set_active_dialog_audio,get_active_dialog_audio

func set_active_dialog_audio(audio): active_dialog_audio = audio
func get_active_dialog_audio(): return active_dialog_audio


var test_export setget set_test_export
	
func _ready():
	player = get_tree().get_current_scene().find_node("player")
#	connect("state_changed",self,"run_state_changed")
	change_state("_ROMMING")
	
func set_test_export(obj):
	test_export = obj
	print(test_export.get_name())
	_File_Handler.fh_save_file("export_test.tscn",str(test_export))

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


var _Player_States = {

#					PHYSICAL
	Money		= 100,
	Health		= 100,
	Hunger 		= 0.0,
	
#					SKILLS
	Understanding 	= 00.0,
	Vocabulary		= 00.0,
	Charisma		= 00.0,
	Speech			= 00.0,
	
}	setget update_player_state, get_player_state

signal player_stats_changed(stats) 

func update_player_state(update_item,update_value): 
	_Player_States[update_item] += update_value
	emit_signal('player_stats_changed',_Player_States[update_item])

func get_player_state(state): return _Player_States[state]

#

var _Inventory = {
	
	test = 2
	
} setget change_inventory_item, get_inventory_item

signal player_inventory_changed(item)

func change_inventory_item(item,value): 
	_Inventory[item] = value
	emit_signal('player_inventory_changed',[item,value])

func get_inventory_item(item):
	return _Inventory[item]

