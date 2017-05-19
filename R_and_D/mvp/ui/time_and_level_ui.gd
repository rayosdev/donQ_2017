#					time_and_level_ui
extends Node2D

var is_panel_open = false

var digit_roll_timer = Timer.new()

export (NodePath) var btn_to_be_rotated
export (NodePath) var root_node

func _ready():
	
	hide()
	if(root_node != null): root_node = get_node(root_node)
	
	digit_roll_timer.set_one_shot(true)
	digit_roll_timer.set_wait_time(0.01)
	add_child(digit_roll_timer)
	
	btn_to_be_rotated = get_node(btn_to_be_rotated)
	pass

func open_panel():
	show()
#	if(is_panel_open == false):
	is_panel_open = true
	get_node("panel_anim").play("show_panel")
	
	get_node("on_inactive_hide").stop()
	get_node("on_inactive_hide").start()
	pass
	
func update_money(value,pos):
	get_node("ui_money_update").money_update(value,pos)
	update_the_money_panel()
	open_panel()
	pass
	
func close_panel():
	is_panel_open = false
	get_node("panel_anim").play("close_panel")
	pass

func _on_btn_pressed():
	if(is_panel_open): 	close_panel()
	else: 				open_panel()
	pass
	
func update_the_money_panel():
	var cash_label = get_node("ui_level_and_cash/cash_stach")
	
	while(_Player.MONEY != int(cash_label.get_text())):
		var money_in_label = int(cash_label.get_text()) 
		if(_Player.MONEY > money_in_label): money_in_label += 1
		else: 								money_in_label -= 1
#		print(cash_label.get_text())
		cash_label.set_text(str(money_in_label))
		digit_roll_timer.start()
		yield(digit_roll_timer,'timeout')
		
	
	

#	
func mouse_over(state):
#	print("mouse_over: " + str(!state))
	root_node.can_place_movement_dot_switch(!state)
	if(state == false and is_panel_open): 
		get_node("on_inactive_hide").start()
		get_node("dropdown_button/btn").set_focus_mode(0)
	else: get_node("on_inactive_hide").stop()
	pass

func _on_inactive_timeout():
	close_panel()
	pass # replace with function body


func show_arrow_on_clock():
	open_panel()
	get_node("clock_anim").play("show_arrow_on_clock 2")
	pass