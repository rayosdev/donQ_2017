extends Node


# Imortan common File obj
var savedFile = File.new()
var csv_file = File.new()
	
	
func _init():
	pass
	
	
# Main Save File Function	
func fh_save_file(localFile,stringToWrite):
	
	firstRun(localFile,stringToWrite)
	
	savedFile.open("user://" + str(localFile), File.WRITE)
	savedFile.store_line(stringToWrite)
	savedFile.close()	
	
	
# Safty feature rune first time // and make a file if not already excisting	
func firstRun(localFile,stringToWrite):
#	if(!typeof(stringToWrite 
	if(savedFile.file_exists("user://" + str(localFile))):
		return
	else:
		savedFile.open("user://" + str(localFile), File.WRITE)
		savedFile.store_line(stringToWrite)
		savedFile.close()
	
	
# Load Function 	
func fh_load_file(localFile):
	if !savedFile.file_exists("user://" + str(localFile)):
		print("ERROR - FILE: %s NOT FOUND" % str(localFile))
		return null
	
	savedFile.open("user://" + str(localFile), File.READ)
	
	var tmpStr = ""
	tmpStr = savedFile.get_as_text()
	savedFile.close()
	
	return tmpStr	
	
	
# Directory read function --> returns list of items in a folder
func fh_ls(dir = "user://"):
	var d = Directory.new()
	if(d.open(dir) == 0):
		d.list_dir_begin()
		var file_name = d.get_next()
		var returnList = []
		while(file_name != ""):
			returnList.append(file_name)
			file_name = d.get_next()
#		for i in returnList:
#			print(i)
		return returnList
	else:
		print("Some open error, maby invalid directory")	
		
		
# Directory read function by extention
func fh_ls_extentions(end = ".txt", dir = "user://"):
	var d = Directory.new()
	if(d.open(dir) == 0):
		d.list_dir_begin()
		var file_name
		var returnList = []
		while(file_name != ""):
			file_name = d.get_next()
			var tmp_file_name = fh_findFileExtentions(file_name, end)
			if(tmp_file_name):
				returnList.append(tmp_file_name)
		return returnList
	else:
		print("Some open error, maby invalid directory")	
		
		
func fh_findFileExtentions(_file_name, _end):
	var endCheck = ""
	for i in range(_file_name.length()):
		if(_file_name[i] == "."):
			for j in range(_file_name.length() - i): # it runs the last char to the end
				endCheck += _file_name[i + j]
	if(endCheck == _end):
		return _file_name
	return null
		
# Directory read function by folders 	
func fh_ls_folders(dir = "user://"):
	var returnList = []
	var d = Directory.new()
	if(d.open(dir) == 0):
		d.list_dir_begin()
		var dir_name
		var returnList = []
		while(dir_name != ""):
			dir_name = d.get_next()
			if(d.current_is_dir()):
				if(!(dir_name == "." or dir_name == "..")):
					returnList.append(dir_name)
		return returnList
		
				
# Make Directory		
func fh_make_dir(dir = "user://", new_folder = "new folder"):
	var d = Directory.new()
	d.open(dir)
	if(d.dir_exists(dir)):
		d.make_dir(dir + new_folder)
		print("Folder created")
		return true
	else:
		print("error: maybe an invalid directory, or directory already exists")
		return false
		
		
# Rename Directory	
func fh_renameDir(dir = "user://", oldFolder = null, newName = "defult"):
	if(oldFolder == null):
		print("Erorr -- Invalid Folder Name")
		return
	var d = Directory.new()
	d.open(dir)
	print("renamingNow")
	d.rename(dir + oldFolder,dir + newName)
	
	
	
	
# Dictonary by ending file
#func ls_a(end = ".txt", dir = "user://"):
#	var d = Directory.new()
#	if(d.open(dir) == 0): #> 
#		d.list_dir_begin()
#		var file_name = d.get_next()
#		var loadList = []
#		var returnList = []
#		while(file_name != ""):
#			loadList.append(file_name)
#			file_name = d.get_next()
#			var endCheck = ""
#			for i in range(file_name.length()):
#				if(file_name[i] == "."):
#					for j in range(file_name.length() - i): # it runs the last char to the end
#						endCheck += file_name[i + j]
#					if(!(endCheck[1] == ".")):
#						if(endCheck == end):
#							returnList.append(file_name)
#						endCheck = ""
#		return returnList
#	else:
#		print("Some open error, maby invalid directory")	
		
		
		
		
		
		
		
		
		
		

func fh_load_csv_file(path_to_csv_file):
	
	csv_file.open("user://" + str(path_to_csv_file), File.READ)
	
	var tmp_str = ""
	var tmp_arr = []
	
	while(!(csv_file.eof_reached())):
		for item in csv_file.get_csv_line(","):
			tmp_arr.append(item)
	csv_file.seek(0)
	csv_file.close()
	
	return tmp_arr	


func fh_del_file(dir,file):
	var d = Directory.new()
	d.remove("user://" + dir + "/" + file)
#	print(d.list_dir_begin())