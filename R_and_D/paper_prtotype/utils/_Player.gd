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
#		NOUN	[Translations..] ,[types..], [catagory..], Word_Score 0-100%, Date Created, Test Dates [date..]], 
		"Mesa":	[["Table"], ['NO'], ['HOME','WORK'] , 0 , OS.get_time(true)],
#			ADJACTIVE
		"Bien":	[["Good"] , ['AV']],
		
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
	
	print(date_format(OS.get_datetime()))
	
	_states["MONEY"] = MONEY
	
	print("states: ")
	for s in _states:
		print(str(_states[s]) + " : " + str(s))
	pass
	
func date_format(date,format = "hh:mm:ss - DD.MM.YYYY"):
	var container = null
	for f in range(format.length()):
		if(container == null):
			container = []
			container.append(format[0])
			continue
		var last_cell = container.size() - 1
		if(format[f] == container[last_cell][0]): container[last_cell] += format[f]
		else: container.append(format[f])
	
	print(date)
	print(container)
	for item in date: item = zero_padding(date)
	
	var return_str = ""
	var i = 0
	for cell in container:
#		(day:4), (dst:False), (hour:18), (minute:8), (month:4), (second:35), (weekday:2), (year:2017)
		if(cell[0] == 'h')	: return_str += parse_time(str(date.hour),cell)
		elif(cell[0] == 'm'): return_str += parse_time(str(date.minute),cell)
		elif(cell[0] == 's'): return_str += parse_time(str(date.second),cell)
		elif(cell[0] == 'D'): return_str += parse_time(str(date.day),cell)
		elif(cell[0] == 'M'): return_str += parse_time(str(date.month),cell)
		elif(cell[0] == 'Y'): return_str += parse_time(str(date.year),cell)
			
		else: return_str += cell
		i += 1		
	
	print(return_str)
	pass
	
func reverse_str(string):
	var return_str = ""
	var string_length = string.length()
	for i in range(string_length): return_str += string[string_length - i - 1]
	return return_str
	pass
	
func zero_padding(number):
	if(number < 2): return "0" + str(number) 
	pass
	
func zero_in_front_padding(number):
	return '0' + str(number)
	
func parse_time(time,cell):
	time = reverse_str(time)
	for j in range(cell.length()): cell[j-1] = time[j-1]
	cell = reverse_str(cell)
	return cell
