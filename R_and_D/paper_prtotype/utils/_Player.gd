#					Player States
extends Node


var MONEY = 100

var unproccesed_words = []

var _states = {}

signal new_word_added

var active_word_list = {

#						"word":{translation_1... processed:false}

} setget set_active_word_list, get_active_word_list
				
var game_word_list = {

#				'words':{
#						'word':{
#								'translations' 	:{1:'translation_1', 2:'translation_2..'},
#								'start_date'	:OS.get_datetime(),
#								'test_dates'	:{1:'test_dates..'},
#								}
#							},
#							
#					'words_without_translation'	:{1:'word_1',2:'word_2..'}
						} setget set_game_word_list, get_game_word_list


func _ready():
	
#	var gwl = {
#		'words':{
#			'word':{
#				'word'			:'example',
#				'translations' 	:{1:'translation_1', 2:'translation_2..'},
#				'start_date'	:OS.get_datetime(),
#				'test_dates'	:{1:'test_dates..'},
#				'is_active'		:false
#				}
#			}
#		}
#	_File_Handler.fh_save_file("game_word_list.json",gwl.to_json())
	
	init_game_word_list()
	
#	for w in game_word_list["words"]:
#		print(w)
	
	_Utils.fprint_dictonarys(get_game_word_list())
	
	_states["MONEY"] = MONEY
	
	
func set_active_word_list(_active_word_list):active_word_list = _active_word_list
func get_active_word_list(): return active_word_list

func add_word_to_active_list(word):
	if(game_word_list.words.has(word)):
		active_word_list[word] = {}
		active_word_list[word]["processed"] = false
	else: 
		print("ERROR: add_word_to_active_list : word [ " + str(word) + " ] note found in [game_word_list]")
		return
	print(active_word_list.keys())
	unproccesed_words.append(word)
	emit_signal("new_word_added")
	pass

func set_game_word_list(_game_word_list): game_word_list = _game_word_list
func get_game_word_list(): return game_word_list

func init_game_word_list():
	var word_list = {}
	word_list.parse_json(_File_Handler.fh_load_file("game_word_list.json"))
#	print(_File_Handler.fh_load_file("game_word_list.json"))
#	print(word_list.parse_json(_File_Handler.fh_load_file("game_word_list.json")))
	set_game_word_list(word_list)
	
	