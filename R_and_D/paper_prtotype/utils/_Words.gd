#					_Words.gd
extends Node


var _Spanish_Words = {

}	setget set_spanish_word_dictonary,get_spanish_word_dictonary

func set_spanish_word_dictonary(dictonary)	: _Spanish_Words = dictonary
func get_spanish_word_dictonary()			: return _Spanish_Words
signal spanish_word_added

func add_spanish_word(word_name,word_contents):
	if(_Spanish_Words.has(word_name)): return print("WARNING - _SPANISH_WORD ALREADY CONTAINS WORD: %s" % str(word_name))
	_Spanish_Words[word_name] = word_contents

	if(_Spanish_Words[word_name].has("dates")):
		if(_Spanish_Words[word_name].dates.has("data_of_discovery")):
			_Spanish_Words[word_name].dates.data_of_discovery = OS.get_unix_time()
		else:	return print("WARRING - WORD: %s IS MISSING 'data_of_discovery' DICTONARY" % str(word_name))
		var dates = schedule_next_date_for_a_test(_Spanish_Words[word_name].dates)
		_Spanish_Words[word_name].dates = dates
		print("DATES: %s FOR WORD: %s" % [str(dates),str(word_name)])
		print("SIZE: %s" % str(dates.size() - 1))
		var last_added_test_date = dates[dates.size() - 1]
		add_to_words_test_schedular(last_added_test_date,word_name)
#		print("DATES SIZE -1: " + )
		print("WORDS_TEST_SCHEDUAL: %s" % str(words_test_schedular))
	else:	return print("WARRING - WORD: %s IS MISSING 'dates' DICTONARY" % str(word_name))

	print(_Utils.ut_fprint_dict(word_contents))
#	print("DATA: " + str(OS.get_datetime_from_unix_time(_Spanish_Words[word_name].data_of_discovery + (60 * 60 * 24 * 7 * 4))))
#	print("DATA2: " + str(OS.get_datetime(true)))


var game_directory = ""

func _ready():
	
#	print("DATE: %s" % str(OS.get_unix_time()))
#	_File_Handler.fh_del_file("","_Spanish_Words")
	print(_File_Handler.fh_ls())
	
	#		Words loading 
	var _spanish_words = {}
	if(_File_Handler.fh_load_file(game_directory +"/"+ "_Spanish_Words") != null):
		_spanish_words.parse_json(_File_Handler.fh_load_file(game_directory +"/"+ "_Spanish_Words"))
#		print(_spanish_words.empty())
	elif(_spanish_words == null):
		_File_Handler.fh_save_file(game_directory +"/"+ "_Spanish_Words",_Spanish_Words.to_json())
		_spanish_words = _Spanish_Words
	
	print(_Utils.ut_fprint_dict(_spanish_words))
	_Spanish_Words = _spanish_words


func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		_File_Handler.fh_save_file("_Spanish_Words",_Spanish_Words.to_json())
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

	print(dates_dictonary)

	# First sheduled test date is three days after data_of_discovery
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

