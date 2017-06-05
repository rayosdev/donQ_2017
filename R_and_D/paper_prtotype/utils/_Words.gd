#					_Words.gd
extends Node


var words_and_test_dates



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
		else:
			return print("WARRING - WORD: %s IS MISSING 'data_of_discovery' DICTONARY" % str(word_name))
		
		_Spanish_Words[word_name].dates = schedule_next_date_for_a_test(_Spanish_Words[word_name].dates)
		
	else:
		return print("WARRING - WORD: %s IS MISSING 'dates' DICTONARY" % str(word_name))
	
	
	print(_Utils.ut_fprint_dict(word_contents))
#	print("DATA: " + str(OS.get_datetime_from_unix_time(_Spanish_Words[word_name].data_of_discovery + (60 * 60 * 24 * 7 * 4))))
#	print("DATA2: " + str(OS.get_datetime(true)))
	
	
	
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
	

