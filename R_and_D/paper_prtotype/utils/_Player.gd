#					Player States
extends Node


var MONEY = 100

var _states = {}

var WORDS = {
		
	#	Words, Translation, Categorys [cat..], Grammer Type [], Score, Date Created, Test Dates [date..], 
		"":"",
		
}

var CATEGORYS = {

		
}


func _ready():
	_states["MONEY"] = MONEY
	
	print("states: ")
	for s in _states:
		print(str(_states[s]) + " : " + str(s))
	pass
	
