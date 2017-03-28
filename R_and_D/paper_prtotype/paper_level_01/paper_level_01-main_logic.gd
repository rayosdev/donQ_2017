#				paper_level_01.gd
extends Node

var term
var dialog_characters = []
var dialog = {}

var spanish_words = []

var can_place_movement_dot = true
#					script level01
var GAME_STATE = {

	"_CURRENT" 	:0,

	"INTRO"			:0,
	"MOVE_AROUND"	:1,
	"CUT_SCENE"		:2

}



func _ready():

	term = get_node("term")
	term.set_text("ready...")
	change_state("INTRO")
	set_process(true)
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

func what_is_the_current_state():
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

#func test():
#	var test_ref = funcref(get_node("player"),"test_for_player")
#	get_node("player").try_func(test_ref,"test_num")
#	pass


	pass