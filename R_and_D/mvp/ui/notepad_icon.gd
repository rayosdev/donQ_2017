#					notepad_icon.gd
extends Node2D

onready var anim 		= get_node("notepad_anim")
onready var button_area = get_node("button_area")

func _ready():
	#		Start Setup For Global Connections
	_Game.add_to_node_refrnaces(get_name(),self)
	_Words.connect('spanish_word_added',self,"new_words_added")
	
	#		Local Start Settings 
	anim.play("idel_off")
	button_area_conections()


#					NEW_WORDS_ADDED()
var new_words_list = []
onready var notification = get_node("notefication")

func new_words_added(new_word):
	if(_Game.debug): print("(ON notepad)	WORD ADDED TO notepad, WORD: %s" % str(new_word['word_name']))
	new_words_list.append(new_word)
	notification.add_to_queue()
	if(_Game.debug):	for key in new_words_list:	print("(ON notepad)	WORDS ADDED: %s" % str(key.word_name))


#					MAKE_ACTIVE()
var is_active

func make_active(active):
	is_active = active
	if(is_active):
		anim.play("make_visable")


#					Setup Button Functions
func button_area_conections():
	button_area.connect("mouse_enter"	,self,"on_mouse_over")
	button_area.connect("mouse_exit"	,self,"on_mouse_exit")
	button_area.connect("button_up"		,self,"on_mouse_button_up")
	button_area.connect("button_down"	,self,"on_mouse_button_down")

onready var icon = get_node("icon")
onready var orgianal_modul_collor = icon.get_modulate()
var btn_down_collor 	= Color("e299d8")
var btn_hover_collor	= Color("b077c8")

func on_mouse_over()		: icon.set_modulate(btn_hover_collor)
func on_mouse_exit()		: icon.set_modulate(orgianal_modul_collor)

onready var is_pressed = false
func on_mouse_button_up()	: 
	icon.set_modulate(btn_hover_collor)
	is_pressed = false

onready var notepad_gui = _Game.get_singel_node_refrence("notepad_gui")

func on_mouse_button_down(): 
	if(is_pressed == true): return
	if(notepad_gui == null): return print("(ON notepad_icon.gd) ERROR - notepad_gui = NULL" )
	icon.set_modulate(btn_down_collor)
	
	if(_Game.get_current_state() == "_NOTEBOOK"): 
		notepad_gui.make_inactive()
		return
	if(_Game.get_current_state() == "_ROMMING"): 
		notepad_gui.make_active()
		return
	is_pressed = true