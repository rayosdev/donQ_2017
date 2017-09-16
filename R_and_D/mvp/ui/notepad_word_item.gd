#					notepad_word_item.gd
extends Container


#		Refrances
var sound_btn
var translation_field
var check_btn
var spanish_word_label

var panel_parant

func _ready():
	#		Setup Refrances
	sound_btn			= get_node("center_contain/hbox_contian/center_sound_btn/soud_btn")
	translation_field	= get_node("center_contain/hbox_contian/center_trans_field/translation_field")
	check_btn			= get_node("center_contain/hbox_contian/check_btn")
	spanish_word_label	= get_node("center_contain/hbox_contian/spanish_word/spanish_word_label")
	#		Setup Connections
	check_btn.connect("pressed",self,"on_check_btn_pressed")
	translation_field.connect("input_event",self,"on_translation_field_input_event")
	
	
#	set_process_input(true)
#	translation_field.grab_focus()


#		Setup start values given by the script doing the initation
func initiate(spanish_word,word_panel_script):
	panel_parant = word_panel_script
	spanish_word_label.set_text(str(spanish_word))
	set_name(str(spanish_word) + " " + "word_panel")


#		Is called by to set focus on the translation feild
func put_in_focus():	
	translation_field.grab_focus()
	if(translation_field.has_focus()): print("GOT FOCUS: " + str(get_name()))


#		Checks the translation acording to the actuall word and contions the translation project
func on_check_btn_pressed():
	hide()
	panel_parant.next_word()
	print("Bye Bye")


#		For keybord use when you press enter the focus gos to the check_btn
func on_translation_field_input_event(event):
	if(event.is_action_pressed("Enter")): 
#		check_btn.grab_focus()
		on_check_btn_pressed()
