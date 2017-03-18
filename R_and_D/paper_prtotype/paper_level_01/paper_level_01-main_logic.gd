extends Node

var term

var GAME_STATE = {
	
	"_CURRENT" :0,
	
	"INTRO"			:0,
	"MOVE_AROUND"	:1,
	"CUT_SCENE"		:2
}

func _ready():
	
	term = get_node("term")
	term.set_text("ready...")
	set_process(true)
	pass
	
func _process(delta):
	if(GAME_STATE._CURRENT == GAME_STATE.INTRO):
		GAME_STATE._CURRENT = GAME_STATE.MOVE_AROUND
		
	if(GAME_STATE._CURRENT == GAME_STATE.MOVE_AROUND):
		get_node("mouse_drag_items").is_active = true
		
	if(GAME_STATE._CURRENT == GAME_STATE.CUT_SCENE):
		get_node("mouse_drag_items").is_active = false
	pass
	
func write_to_term(_str):
	term.set_text(term.get_text()+ "\n" + str(_str))
	