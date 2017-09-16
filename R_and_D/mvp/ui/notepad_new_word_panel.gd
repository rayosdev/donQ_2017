#					notepad_new_word_panel.gd
extends Control


export (PackedScene) var word_item 


#		Words to be instanciated
var word_item_objects 	= []
var new_word_list 		= {}
func add_word_to_new_word_list(word):
	#		Get content for the words_item
	var name_of_word = word.word_contents.word
	new_word_list[name_of_word] = word.word_contents
	#		Instance and add word_item
	var new_item = word_item.instance()
	find_node("vbox").add_child(new_item)
	word_item_objects.append(new_item)
	#		Setup the word_item with values
	new_item.initiate(name_of_word,self)


func _ready():
	#		Setup Connections When new words are added
	_Words.connect("gameplay_word_added",self,"add_word_to_new_word_list")
	self.connect("visibility_changed",self,"on_visibility_changed")


func on_visibility_changed():
	if(is_visible()):	
		if(word_item_objects.empty() == false):
			word_item_objects[0].put_in_focus()


#		Recive messege back from word before it ends 
#			to sett make active the next word in the list 
func next_word():
	word_item_objects.pop_front()
	if(word_item_objects.empty() == false):
		word_item_objects[0].put_in_focus()