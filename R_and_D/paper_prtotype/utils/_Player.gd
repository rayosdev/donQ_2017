#					Player States
extends Node


var MONEY = 100

var _states = {}


var WORD_TYPES = {

		"NOUN"			:'NO',
		"VERB"			:'VE',
		"ADJACTIVE"		:'AD',
		"ADVERB"		:'AV',
		"PRONOUN"		:'PN',
		"PREPOSITION"	:'PP',
		"CONJUNCTION"	:'CO',
		"DETERMINER"	:'DT',
		"EXCLAMATION"	:'EC'
		
}



var PHRASES = {

#		Phrase, 
}


var VERB_LIST = {

	#EXAMPLE
	#VERB
	["comer",'VB']:{
		
		'_WORD'			:	"comer",
		'_TYPE'			:	"VB",
		'_TANSLATION'	:	{1:"eat",2:"consume"},
		'_CATEGORY'		:	{1:"HOUSE",2:"SHOP",3:"RESTAURANT"},
		'_PROGRESS'		:	0,
		'_DATE_ADDED'	:	OS.get_date(),
		'_TEST_DATES'	:	{},
		'_CONJUGATION'	:	{
			'_INFINITIVE':
				{
				'YO'		:"como",
				'TU'		:"comes",
				'USTED'		:"come",
				'NOSOTROS'	:"comamos",
				'USTEDES'	:"comen",
				}
			
			}
	}
}
	
var NOUN_LIST = {
	#EXAMPLE	
	#NOUN
	"casa":{
		
		'_WORD'			:	"casa",
		'_TYPE'			:	"NO",
		'_TANSLATION'	:	{1:"house",2:"home"},
		'_GENDER'		:	'F',
		'_CATEGORY'		:	{1:"HOME"},
		'_PROGRESS'		:	0,
		'_START_DATE'	:	OS.get_datetime(),
		'_TEST_DATES'	:	{},
		
	}
	
}

func add_to_verb_list(word,type,translation,category,progress,start_date,test_dates,conjugation):
	
		VERB_LIST[word] = {
		
		'_WORD'			:	word,
		'_TYPE'			:	type,
		'_TANSLATION'	:	translation,
		'_CATEGORY'		:	category,
		'_PROGRESS'		:	progress,
		'_START_DATE'	:	start_date,
		'_TEST_DATES'	:	test_dates,
		'_CONJUGATION'	:	conjugation
		
		}
		
		 
	
func add_to_noun_list(word,type,translation,gender,category,progress,start_date,test_dates):
	
		VERB_LIST[word] = {
		
		'_WORD'			:	word,
		'_TYPE'			:	type,
		'_TANSLATION'	:	translation,
		'_GENDER'		:	gender,
		'_CATEGORY'		:	category,
		'_PROGRESS'		:	progress,
		'_START_DATE'	:	start_date,
		'_TEST_DATES'	:	test_dates,
		
		} 



func _ready():
	
	
	for word in NOUN_LIST:
		_FILE_HANDLER.fh_save_file(word + ".json", NOUN_LIST[word].to_json())
		var tmp_dict = {}
		tmp_dict.parse_json(_FILE_HANDLER.fh_load_file(word + ".json"))
		
		print(tmp_dict["_TANSLATION"]["2"])
		
#	_UTILS.ut_csv_to_dict(_FILE_HANDLER.fh_load_csv_file("test.csv"))
	
	
#	print(reverse_str("HA HA HA DETTE ER BRA"))

#	print(date_format(OS.get_datetime(),"DD.MM.YY"))
	
	_states["MONEY"] = MONEY
	
#	print("states: ")
	for s in _states:
#		print(str(_states[s]) + " : " + str(s))
		pass
	
