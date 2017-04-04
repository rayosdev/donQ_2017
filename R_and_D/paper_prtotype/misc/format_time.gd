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
	
	for item in date: date[item] = zero_padding(date[item])
	print(date)
	
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
	
#			!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
#			Ther is a problem in the reversal where when format is YY 
#			the first and the last digit are sat togheter in other words 2017 becomes 27 insted of 17
#				this is probably because of the revers function
	
func reverse_str(string):
	var return_str = ""
	var string_length = string.length()
	for i in range(string_length): return_str += string[string_length - i - 1]
	return return_str
	pass
	
func zero_padding(number):
	if(typeof(number) == 1): return number
	if(number < 10): 
		return "0" + str(number) 
	return number
	pass
	
func parse_time(time,cell):
	time = reverse_str(time)
	for j in range(cell.length()): cell[j-1] = time[j-1]
	cell = reverse_str(cell)
	return cell


