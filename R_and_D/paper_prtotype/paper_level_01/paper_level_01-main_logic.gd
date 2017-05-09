#				paper_level_01.gd
extends Node

var term
var dialog_characters = []
var dialog = {} setget set_dialog, get_dialog

var spanish_words = []

var can_place_movement_dot = true
#					script level01
var GAME_STATE = {

	"_CURRENT" 	:0,

	"INTRO"			:0,
	"MOVE_AROUND"	:1,
	"CUT_SCENE"		:2,
	"NOTEBOOK"		:3,

}

signal notebook

#export (int,'test1','test2','test3') var test

func _ready():
	
	term = get_node("level_01/term")
	term.set_text("ready...")
	change_state("INTRO")
#	change_state("NOTEBOOK")
	set_process(true)
#	print(get_current_state())
	
	#	- new_func - use the mouse to set a destination position everytime the 
	#	...mouse clicks 
	set_process_input(true)
	pass

func _process(delta):

	pass


func write_to_term(_str):
	term.set_text( str(_str) + "\n" + term.get_text() )


func change_state(state):
	if(typeof(state) == 4):
		for k in GAME_STATE.keys():
			if(k == state):
				GAME_STATE._CURRENT = GAME_STATE[state]
				run_states_once()
				return

	if(typeof(state) == 2):
		for i in GAME_STATE.values():
			if(i == state):
				GAME_STATE._CURRENT = state
				run_states_once()
				return

	return "'" + str(state) + "' was not in GAME_STATE: \n" + str(GAME_STATE)


func get_current_state():
	
	for i in GAME_STATE:
		if(i == "_CURRENT"): break
		if(GAME_STATE[i] == GAME_STATE._CURRENT): return i


func run_states_once():

	switch_state_spesific_functions_off()

	if(GAME_STATE._CURRENT == GAME_STATE.INTRO):
		#Intro to the state
		write_to_term("state: INTRO")

		change_state("MOVE_AROUND")
		pass


	elif(GAME_STATE._CURRENT == GAME_STATE.MOVE_AROUND):
		#intro to the state
		write_to_term("state: MOVE_AROUND")

		get_node("player").can_move = true
		pass


	elif(GAME_STATE._CURRENT == GAME_STATE.CUT_SCENE):
		#intro to the state
		write_to_term("state: CUT_SCENE")

		get_node("cutscene").is_active = true
		get_node("cutscene").run()
		pass
		
	elif(GAME_STATE._CURRENT == GAME_STATE.NOTEBOOK):
		emit_signal("notebook")
		write_to_term("state: NOTEBOOK")
		
		pass
	pass


func switch_state_spesific_functions_off():

	get_node("player").can_move = false
	get_node("mouse_drag_items").is_active = false
	get_node("cutscene").is_active = false
	get_node("cutscene").run()
	pass


func can_place_movement_dot_switch(state):
	can_place_movement_dot = state
	pass


func add_spanish_words(words_to_be_added):
	for word in words_to_be_added:
		spanish_words.append(word)		
	pass


func get_dialog():
	return dialog


func set_dialog(_dialog):
	dialog = _dialog
	if(dialog["spanish_words"].size() > 1):
		get_node("player/words_poping_anchor").set_spanish_words_list(dialog["spanish_words"])

#func test():
#	var test_ref = funcref(get_node("player"),"test_for_player")
#	get_node("player").try_func(test_ref,"test_num")
#	pass

func start_conversation(actors = [], conversation = {}):
	
	dialog_characters = []
	for c in actors: dialog_characters.append(c)
	dialog = conversation
	
	change_state("CUT_SCENE")
	pass
	
#	- new_func - get the mouse click and mouse postion and send it to "player_actor"
func _input(event):
	
	if(Input.get_mouse_button_mask() == 1):
		get_node("player_actor").move_actor(get_tree().get_root().get_mouse_pos())
	pass