extends Node


func _ready():	pass
	
#	var dict = {"test_1":1,"test_2":2,"test_3":3}
#	print(str(dict))
#	var dict2 = ut_str_to_dic(str(dict))
	
#	dict2.test_1 += 100
#	print(dict2)
#	var os_time = OS.get_datetime(true)
#	print(os_time)
#	var test_dict = {1:1,	2.2:2,	"test_3":3,	[1,"test dette",3,4]:4,	"dict":{"test5":5},"os_time":os_time}
#	File_Handler.fh_save_file("test.json", test_dict.to_json())
#	var back_test = {}
#	back_test.parse_json(File_Handler.fh_load_file("test.json"))
#	print(back_test)
#	print(back_test.os_time.year)
	
#	for i in test_dict: ut_from_str_to_correct_type(str(i))
#	for k in test_dict.keys(): print(k)
#
#	var test_dict2 = {}
#	test_dict2 = ut_str_to_dic(str(test_dict))
#	
#	print(test_dict2.test_3)

#	print(" ")
#	print(" ")
#	print(" ")
#	print(ut_from_str_to_correct_type(str([1.1,2000,3,4])))
#	print(ut_from_str_to_correct_type(str(["1",".2","_3",",4","Dette"])))
#	ut_fprint_dict(test_deic)
	
#var test_deic = {
#	
#	'a' : 1,
#	'b' : 2,
#	'c' : 3,
#	'd' : 	{
#			'a1':1,
#			'd' : 	{
#					'a1':1
#					},
#			},
#}
	
func ut_fprint_dict(dict = {}):
	var item 	= ''
	var item	= ''
	var indent 	= ''
	var tmp_arr = []
#	print(dict.to_json())
	for c in dict.to_json():
		
		if(c == '{'):
			if(item.length() > 0):
				print(indent + item + c + '\n')
				item = ''
			else: print(indent + c + '\n')
			indent += '          ' 
	
		elif(c == '}'):
			if(item.length() > 0):
				print(indent + item + '\n')
				item = ''
			var l = indent.length()
			if( l > 4):indent.erase(l - 10,l)
			print(indent + c)
		
		elif(c == ','):
			item += ','
			print(indent + item)
			item = ''
		
#		elif(c == '"'):
#			if(item)
#			print(indent + item)
#			item = ''
#			item += c

		else:
			if(c == ':'):
				item += " " + str(c) + " "
			else: item += c
			
	pass


func update_indention(add_retract_sum = 0,indention = [0,'']):
	print(indention)
	indention[0] += add_retract_sum
	var tmp_str = ''
	for i in range(indention[0]): tmp_str += '-'
	indention[1] = tmp_str
	return indention
	print(indention)


func fprint_dictonarys(dict):
	var space = ""
	if(typeof(dict) == 20):
		for i in dict:
			print(str(i))
			
			for _i in dict[i]:
				print("	" + str(_i)) #+ " : " + str(dict[i][_i]))
				
				for __i in dict[i][_i]:
					print("		" + str(__i) + " : " + str(dict[i][_i][__i]))
			
	
func ut_str_to_dic(_str):
	_str = str(_str)
	print("string to validate for dict: " + _str)
	if(_str[0] != '('):
		print("string is not a dictonary, missing opening ( in index 0")
		return
	
	var seek_key_mode = false
	var seek_value_mode = false

	var return_dict = {}
	
	var key = ""
	var value = ""
	for i in _str:
		if(i == "("):
			#start of a cell
			seek_key_mode = true
			continue
		# check if seperater ":" is reached while seek_in key_mode
		if(i == ":" and seek_key_mode):
			seek_key_mode = false
			seek_value_mode = true
			continue
		# check if end cell is reaced ")"
		if(i == ")" and seek_value_mode):
			seek_value_mode = false
			key = ut_from_str_to_correct_type(key)
			value = ut_from_str_to_correct_type(value)
			return_dict[key] = value
			key = ""
			value = ""
			print(return_dict)
		if(seek_key_mode):
			key += i
		if(seek_value_mode):
			value += i
	return return_dict
	pass

	

func ut_from_str_to_correct_type(str_to_convert):
	var return_value
	
	#check if . is in the str
	if(str_to_convert.is_valid_float()):
		for i in str_to_convert: 
			if(i == "."):
				return_value = float(str_to_convert)
				print("valid float " + str(return_value))
				return return_value
				
	if(str_to_convert.is_valid_integer()): 
		return_value = int(str_to_convert)
		print("valid int " + str(return_value))
		return return_value
	
#	print("value testet for array: " + str(str_to_convert))
	if(ut_is_valid_array(str_to_convert)):
		return_value = array(str_to_convert)
		print("valid array " + str(return_value))
		return return_value
		
	print("string to validate for dict: " + str_to_convert)
	if(ut_is_valid_dictonary(str_to_convert)):
		print("VALID DICT")
		return_value = ut_str_to_dic(str_to_convert)
		print("valid dictonary " + str_to_convert)
		
		
	print("valid string " + str_to_convert)
	return_value = str_to_convert
	
	return return_value
	pass


func ut_is_valid_dictonary(_str):
	if(_str[0] == "(" and _str[_str.length() - 1] == ")"): return true
	pass
	
	
func ut_is_valid_array(_str):
	#check for cels in the array
	if(_str[0] != "[" and _str[_str.length() - 1] != "]"): return false
	if(array(_str) == null): return false
	else :return true
	pass
	
func array(_str):
	if(_str[0] != "[" and _str[_str.length() - 1] != "]"): return null
	
	var return_arr = []
	var arr_index = null
	var cel_str = ""
	var start_new_cell = false
	
	for char in _str:
#		print("char = " + char)
		#Start of array
		if(char == "["): 
			arr_index = 0
			continue
			
		if(char == ","):
			start_new_cell = true
			continue
			
		#end of the array
		if(char == "]"):
			start_new_cell = true
			
		if(start_new_cell):
			return_arr.append(ut_from_str_to_correct_type(cel_str))
#			print("****|" + str(return_arr[arr_index]) + "|****")
			cel_str = ""
			arr_index += 1
			start_new_cell = false
			
		if(arr_index != null and start_new_cell == false):
			cel_str += char
			
	print("return array: " + str(return_arr))
	return return_arr
	pass


func ut_csv_to_dict(csv_file):
#	[_WOERD, _TYPE, _TRANSLATION @[], _GENDER, _CATEGORY @[], _PROGRESS, csas, NO, [house,home], F, [home], 0, ]
#	print(csv_file)
	for items in csv_file:
		pass

#	checks if value is between low and high and returns bool
func _is_within_margins(value, low, hight):
	if(value >= low and value <= hight): return true
	else: return false
	pass