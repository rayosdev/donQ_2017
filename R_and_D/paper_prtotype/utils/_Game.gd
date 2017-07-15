#					_Game.gd
extends Node

var player

var debug = false

signal state_changed(state)


var _State = {
		
	_CURRENT		= null,
	
	_ROMMING		= 0,
	_CONVERSATION	= 1,
	_NOTEBOOK		= 2,
	
} setget get_current_state, change_state



var active_dialog = {} setget set_active_dialog,get_active_dialog

func set_active_dialog(dialog): active_dialog = dialog
func get_active_dialog(): return active_dialog


var active_dialog_audio setget set_active_dialog_audio,get_active_dialog_audio

func set_active_dialog_audio(audio): active_dialog_audio = audio
func get_active_dialog_audio(): return active_dialog_audio


	
func _ready():
	player = get_tree().get_current_scene().find_node("player")
#	connect("state_changed",self,"run_state_changed")
	change_state("_ROMMING")
	

func get_current_state(): return _State._CURRENT

func change_state(state):
	_State._CURRENT = state
	if(debug):	print("change_state: @ %s" % _State._CURRENT)
	emit_signal("state_changed", _State._CURRENT)


func run_state_changed(state):
	print("run_state_changed: @ %s" % state)
	if(_State._CURRENT == "_ROMMING")		: print("_ROMMING is running")
	if(_State._CURRENT == "_CONVERSATION")	: print("_CONVERSATION is running")
	if(_State._CURRENT == "_NOTEBOOK")		: print("_NOTEBOOK is running")



var _Player_Stats = {

#					PHYSICAL
	Money		= 100,
	Health		= 100,
	Hunger 		= 0.0,
	
#					SKILLS
	Understanding 	= 00.0,
	Vocabulary		= 00.0,
	Charisma		= 00.0,
	Speech			= 00.0,
	
}	setget set_player_stats, get_player_stats

signal player_stats_changed()

func set_player_stats(_player_stats): 
	_Player_Stats = _player_stats
	emit_signal('player_stats_changed')

signal single_player_stat_changed(stat)

func change_singal_stat(stat,sum):
	if(_Player_Stats.has(stat) == false): return print("ERROR - STAT: '%s' NOT FOUND IN update_singal_player_stat" % str(stat))
	_Player_Stats[stat] = _Player_Stats[stat] + sum
	if(debug):	print("CHANGED STAT: %s TO: %s" % [str(stat),str(_Player_Stats[stat])])
	emit_signal('single_player_stat_changed',[stat,_Player_Stats[stat]])
	
func get_single_player_stat(stat):
	if(_Player_Stats.has(stat) == false): return print("ERROR - STAT: '%s' NOT FOUND IN get_single_player_stat" % str(stat))
	return _Player_Stats[stat]

func get_player_stats(): 	return _Player_Stats


var node_refrences = {
	'example_name':{
			'referance':null,
			'other_configs':'...',
			},
} setget set_node_refrences, get_node_refrences
func set_node_refrences(_node_refrences): node_refrences = _node_refrences
func get_node_refrences(): return node_refrences
func add_to_node_refrnaces(node_name,refrance):
	node_refrences[node_name] = {'refrence':refrance}
	return node_refrences
func get_singel_node_refrence(node_name):
	if(node_refrences.has(node_name)): return node_refrences[node_name].refrence
	else: return print("(ON _Game.gd)	ERROR - FAILD TO FIND NODE REFERANCE: %s IN node_refremces" % str(node_name))