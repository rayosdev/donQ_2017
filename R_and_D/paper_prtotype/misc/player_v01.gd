#				script	player_movement.gd
extends Sprite


var can_move = false
export (PackedScene) var dot

var move_speed = 5
var move_vector = Vector2()
var destination

var note_book_reminder = {

	"is_speach":false,
	"callback_end_functions":[],
	"spanish_words":[],
	"paused_dialog_adress": null,

	['A',1]:['E', 1 , null , 'I should probably look at the new words In the "NOTEBOOK" before I get going too', null,null,null],
##	['A',2]:['C', 0, "start_second_notepad_reminder", null, 'N', false],
##	['A',2]:['E', 1 , null , "I need to get going, Adios", ['adios'],"test", ['none']],

}



export (NodePath) var root_node

#	inventory bunch
export (NodePath) var notepad_node

export (NodePath) var time_and_money

var dots = []

onready var inventory = {}

func _ready():

	if(root_node != null): root_node = get_node(root_node)
	notepad_node = get_node(notepad_node)
	time_and_money = get_node(time_and_money)

	time_and_money.open_panel()

	set_fixed_process(true)
	set_process_input(true)

	make_inventory()
	pass

func make_inventory():
	inventory = {

		"Notebook":[false, "type_ui", notepad_node]

	}


func _fixed_process(delta):

	move_player()
	pass

#	=><
func _input(event):


	#if mouse is over areas where placing a go button is bad
	if(root_node.can_place_movement_dot == false): return

	# sets the destination vector to the mouse position
	if(Input.get_mouse_button_mask() == 1):
		destination = get_tree().get_root().get_mouse_pos()

		#destroy old dots
		if(dots.size() >= 1):
			dots[0].queue_free()
			dots.pop_front()

		#make dots
		var inst_dot = dot.instance()
		root_node.add_child(inst_dot)
		inst_dot.set_global_pos(destination)

		#store dot for destruction later
		dots.append(inst_dot)

		pass
#	if(parant != null): parant.write_to_term("test")


func move_player():
	if(!can_move):
		destination = null
		if(dots.size() >= 1):
			dots[0].queue_free()
			dots.pop_front()
		return
	#reset move_vector so it dosent increas expentional
	move_vector *= 0

	# move player tworeds destination
	if(destination != null):
		if(destination.x <= get_pos().x): move_vector += Vector2(-1,0)
		if(destination.x >= get_pos().x): move_vector += Vector2(1,0)
		if(destination.y <= get_pos().y): move_vector += Vector2(0,-1)
		if(destination.y >= get_pos().y): move_vector += Vector2(0,1)

		#increas speed
		move_vector *= move_speed

		#stabelaize the end movment
		var x = get_pos().x
		var y = get_pos().y
		var dx = destination.x
		var dy = destination.y

		if(abs(x - dx) < move_speed):
			x = dx
			move_vector.x = 0
		if(abs(y - dy) < move_speed):
			y = dy
			move_vector.y = 0

		set_pos(Vector2(x,y))
		set_pos(get_pos() + move_vector)


func add_to_inventory(item):
	print(item)
	if(inventory.has(str(item[0]))):
		inventory[item[0]][0] = true
		update_inventory()

func update_inventory():

	for i in inventory:
		if(inventory[i][0] == true):
			if(inventory[i][1] == "type_ui"):
				inventory[i][2].show()



func _dialog_callback_function(func_name_and_args):
	print("test_dialog_callback_function")
	var call_function = funcref(self,func_name_and_args[0])
	call_function.call_func(func_name_and_args[1])
	pass

func update_money(money_arg):
#	time_and_money.open_panel()
	_Player.MONEY += money_arg[0]
	time_and_money.update_money(money_arg[0], get_global_pos())
	pass

#func test_for_player(t):
#	print("test great succes: " + str(t))
#
#func try_func(_func, t):
#	_func.call_func(t)

func notebook_reminder(wait_time):
	#	sttart a timer to count down before reminder grapgics
	#	tell the player how to look in the notebook	
	#	timer setup
	var is_notebook_used = false
	var notebook_remind_timer = Timer.new()
	add_child(notebook_remind_timer)
	notebook_remind_timer.set_one_shot(true)
	notebook_remind_timer.set_wait_time(wait_time[0])
	notebook_remind_timer.start()
	print("RIMENDER START")
	yield(notebook_remind_timer,"timeout")
	if(root_node.get_current_state() == "NOTEBOOK"): return
	if(is_notebook_used == false):
		root_node.start_conversation([self,self], note_book_reminder)

func test(none):
	print("TEST")
	pass
