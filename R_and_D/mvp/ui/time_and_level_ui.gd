#					time_and_level_ui
extends Node2D

var ui_level_and_cash
var dropdown_button


func _ready():
	
	ui_level_and_cash 	= get_node("ui_level_and_cash")
#	dropdown_button		= get_node("dropdown_button/button")
	
#	dropdown_button.connect("pressed",self,"show_ui")
	_Game.connect("single_player_stat_changed",self,"stat_changed")


func stat_changed(stat_and_value):
#	print("STAT AND VALUE: %s" % str(stat_and_value))
	if(stat_and_value[0] != 'Money'): return
	ui_level_and_cash.update_cash(int(stat_and_value[1]))
	show_ui()


func show_ui():
	self.show()
	ui_level_and_cash.make_visable()
	