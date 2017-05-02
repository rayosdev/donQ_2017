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
	
									#	init_game_word_list()
	
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
	
	
	
	
func check_translation_atempt(word,atempt):
	
	if(game_word_list["words"].has(word) == false): return print("Word @%s: not wound in @game_word_list" % word)
	
	#	build 2 lists one with each translation for a word, ...
	#	one with how close the atempt is to a given translations
	var translation_atempt_scores = {}
	var translations = game_word_list["words"][word].translations
	
#	print(translations)
	for t in translations:
		print("transaltion: %s" %translations[t])
		translation_atempt_scores[translations[t]] = test_fidelity(atempt,translations[t])
	
	print(translation_atempt_scores)
	var top_score_entry = ["atempt",0]
	for e in translation_atempt_scores:
		if(top_score_entry[1] < translation_atempt_scores[e]):
			top_score_entry = [e,translation_atempt_scores[e]]
	
	print("TOP SCORE ON ATEMPT @%s WITH SCORE @%s" % [top_score_entry[0], top_score_entry[1] * 100]  + "%")
	print(top_score_entry)
	print(translation_atempt_scores)
	
	print("TEST THE TOP SCORE: @%s - @%s" % [top_score_entry[0], top_score_entry[1]])
	return top_score_entry
	pass
	
#		!need more functions to test the word fidelity like 
#		letter by letter comperesion 


func test_fidelity(atempt,translation):
	var  exception_characters = []
	
	atempt = atempt.to_lower()
	var score = 0
	
	#check if they are the same word
	if(atempt == translation): 
		score = 1
	
	#Are they both of equal length
	if(atempt.length() == translation.length()): 
	
		var length = atempt.length()
		for i in range(atempt.length()):
			print("Atempt: @%s and Translation: @%s" % [atempt[i], translation[i]])
			if(atempt[i] == translation[i]): score += 1.0/atempt.length()
			else:score += exception_characters_test(atempt[i], translation[i], length)
			
	print("Score: @%s" % score)
	if(score > 1): score = 1
	return score
	pass


func exception_characters_test(atempt_char, translation_char, length):
	var score = 0
	var typical_exception_characters = {'a':'á', 'e':'é', 'i':'í', 'o':'ó'}
	var special_exception_characters = {'u':['ú','ü'], 'n':['ñ']}
	
	for c in typical_exception_characters:
		if(atempt_char == c): score += 1.0/length
		
	return score