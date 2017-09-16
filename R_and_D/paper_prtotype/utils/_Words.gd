#					_Words.gd
extends Node

#		Dictonary containing spanish words added by the game play and important information
var _words_from_gameplay = {}	setget set_spanish_word_dictonary,get_spanish_word_dictonary

func set_spanish_word_dictonary(dictonary)	: _words_from_gameplay = dictonary
func get_spanish_word_dictonary()			: return _words_from_gameplay
signal gameplay_word_added
#		Adding a single word and processing it
func add_spanish_word(word_name):
	if(_words_from_gameplay.has(word_name)): 
		if(_Game.debug): print("WARNING - _words_from_gameplay ALREADY CONTAINS WORD: %s" % str(word_name))
		return
	var word_contents = get_word_from_word_database(word_name)
	_words_from_gameplay[word_name] = word_contents

	if(_words_from_gameplay[word_name].has('is_processed') 				 == false): _words_from_gameplay[word_name]['is_processed'] = false
	if(_words_from_gameplay[word_name].has('progress') 					 == false): _words_from_gameplay[word_name]['progress'] = null
	if(_words_from_gameplay[word_name].has('mnemoics') 					 == false): _words_from_gameplay[word_name]['mnemoics'] = {}
	if(_words_from_gameplay[word_name].has('dates') 					 == false): _words_from_gameplay[word_name]['dates']	= {}
	if(_words_from_gameplay[word_name]['dates'].has("data_of_discovery") == false): _words_from_gameplay[word_name]['dates']["data_of_discovery"] = null
	_words_from_gameplay[word_name]['dates']['data_of_discovery'] = OS.get_unix_time()
	var dates = schedule_next_date_for_a_test(_words_from_gameplay[word_name].dates)
	_words_from_gameplay[word_name].dates = dates
#	print("DATES: %s FOR WORD: %s" % [str(dates),str(word_name)])
#	print("SIZE: %s" % str(dates.size() - 1))
	var last_added_test_date = dates[dates.size() - 1]
	add_to_words_test_schedular(last_added_test_date,word_name)
	print("WORDS_TEST_SCHEDUAL: %s" % str(words_test_schedular))

	print("WOORD_CONTENNTS: %s" % _Utils.ut_fprint_dict(word_contents))
	emit_signal("gameplay_word_added", {'word_name':word_name,'word_contents':word_contents})
#	print("(ON: _Words.gd) TEST PRINT _words_from_gameplay: %s" % str(_words_from_gameplay))


var game_directory = ""

func _ready():
	_word_database_init()
	_File_Handler.fh_del_file("","_words_from_gameplay")

	var _words_from_gameplay = {}
	if(_File_Handler.fh_load_file(game_directory +"/"+ "_words_from_gameplay") != null):
		_words_from_gameplay.parse_json(_File_Handler.fh_load_file(game_directory +"/"+ "_words_from_gameplay"))
	elif(_words_from_gameplay == null):
		_File_Handler.fh_save_file(game_directory +"/"+ "_words_from_gameplay",_words_from_gameplay.to_json())
		_words_from_gameplay = _words_from_gameplay
	
	_words_from_gameplay = _words_from_gameplay


func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		_File_Handler.fh_save_file("_words_from_gameplay",_words_from_gameplay.to_json())
		print("NOTIFICATION: %s" % str(what))


#	'adiós'	:{
#				'word'				:'adiós',
#				'translation'		:{1:'goodbye ',2:'bye'},
#				'is_processed'		:false,
#				'grammer_group'		:'NOUN',
#				'gender'			:'M',
#				'dates'				:{
#									'data_of_discovery'	:null,
#									1					:1496377193,
#										}
#				'special_status'	:null,
#				'progress'			:null,
#				'mnemoics'			:{},
#			},

var words_test_schedular = {

			1231235:{'words':{1:'word1',2:'word2...'}}

} setget set_words_test_schedular, get_words_test_schedular

func set_words_test_schedular(_schedular)	: words_test_schedular = _schedular
func get_words_test_schedular()				: return words_test_schedular

func add_to_words_test_schedular(test_date,word):
	if(words_test_schedular.has(test_date) == false):
		words_test_schedular[test_date] = {}
	
	var dir_size = words_test_schedular[test_date].size()
	words_test_schedular[test_date][dir_size + 1] = word


func remove_from_words_test_schedular(test_date,word):
	var wts = words_test_schedular[test_date]
	for key in wts.keys():
		if(wts[key] == word):
			wts.erase(key)


func schedule_next_date_for_a_test(dates_dictonary):

	var t = {
		seconds	= 1,
		minutes	= 1 * 60,
		hours	= 1 * 60 * 60,
		days	= 1 * 60 * 60 * 24,
		weeks	= 1 * 60 * 60 * 24 * 7,
		months	= 1 * 60 * 60 * 24 * 30,
		years	= 1 * 60 * 60 * 24 * 365,
	}

	#		Shedluling review date
	if(dates_dictonary.size() == 1):
		dates_dictonary[1] = dates_dictonary.data_of_discovery + (t.hours * 3)

	elif(dates_dictonary.size() == 2):
		dates_dictonary[2] = dates_dictonary.data_of_discovery + (t.days * 3)

	elif(dates_dictonary.size() == 3):
		dates_dictonary[3] = dates_dictonary.data_of_discovery + (t.weeks * 1)

	elif(dates_dictonary.size() == 4):
		dates_dictonary[4] = dates_dictonary.data_of_discovery + (t.months * 1)

	elif(dates_dictonary.size() == 5):
		dates_dictonary[5] = dates_dictonary.data_of_discovery + (t.months * 3)

	elif(dates_dictonary.size() == 6):
		dates_dictonary[6] = dates_dictonary.data_of_discovery + (t.years * 1)

	elif(dates_dictonary.size() == 7):
		dates_dictonary['finished'] = true
		print("WORD FINISHED")
		
	return dates_dictonary


func _word_database_init():
	pass


var _word_database = {

'dinero':{
			'word'				:'dinero',
			'translation'		:{1:'money',},
			'grammer_group'		:'INTERJECTION',
			'special_status'	:null,
			
#								'is_processed'		:false,
#								'dates'				:{'data_of_discovery':null},
#								'progress'			:null,
#								'mnemoics'			:{},
		},
'hola'	:{
			'word'				:'hola',
			'translation'		:{1:'hello',2:'hi'},
			'grammer_group'		:'INTERJECTION',
		},
'adiós'	:{
			'word'				:'adiós',
			'translation'		:{1:'goodbye ',2:'bye'},
			'grammer_group'		:'NOUN',
			'gender'			:'M',
		},
'trabajo'	:{
			'word'				:'trabajo',
			'translation'		:{1:'work ',2:'job'},
			'grammer_group'		:'NOUN',
			'gender'			:'M',
		},


}
func get_word_from_word_database(word_name):
	if(_word_database.has(word_name)):
		return _word_database[word_name]


