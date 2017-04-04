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


var WORDS = {
		
#		TEMPLATE:
	#	Word: [[Translations..] , [types..], Categorys [cat..], Grammer Type [], Word_Score 0-100%, Date Created, Test Dates [date..]], 
#				-- EXAMPEL -- 
#		NOUN	[Translations..] ,[types..]	, gender(F,M),   [catagory..], Word_Score 0-100%, Tool_word Date discoverd, Test Dates [date..], Audio	], 
		"Mesa":	[["Table"], 	  ['NO'],   		'F',		['HOME','WORK'] 	, 0 , 			false,		null,			null,		  null		],
#			ADJACTIVE
#		"Bien":	[["Good"] , ['AV']],
#			VERB [Translations..],[types..], [catagory..], 		Word_Score 0-100%, Tool_word Date discoverd, Test Dates [date..], Audio], 
		"Comer":[["Eat,Consume"], ['VE'],   ['HOME','ON_THE_TOWN'] 	, 0 , 			false,		null,			null,			   null	],
#		
}

var PHRASES = {

#		Phrase, 
}

var CATEGORYS = {
		
		#some example categorys
#		Categorys		: icon
		"HOME"			: null,
		"EXPRESSION"	: null,
		"NUMBERS"		: null,
		"PERSONS"		: null,
		"CONVERSATIONS"	: null,
		"SPORTS"		: null,
		"WORK"			: null,
		"FEELINGS"		: null,
		"FOOD"			: null
		
}


func _ready():
#	print(reverse_str("HA HA HA DETTE ER BRA"))
	
#	print(date_format(OS.get_datetime(),"DD.MM.YY"))
	
	_states["MONEY"] = MONEY
	
	print("states: ")
	for s in _states:
		print(str(_states[s]) + " : " + str(s))
	pass
	
