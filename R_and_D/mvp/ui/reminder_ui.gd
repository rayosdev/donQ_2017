#					reminder_ui.gd
extends Node2D

onready var anim 		= get_node("anim")
onready var wait_timer 	= get_node("wait_timer")
onready var close_btn 	= get_node("close")

func _ready():
	#		Setup Connections
	_Game.add_to_node_refrnaces(self.get_name(),self)
	close_btn.connect("pressed",self,"close")
	#		Setup Start State
	anim.play("idel")
	


onready var reminder_text = get_node("reminder_palat/text")
signal reminder_text_changed
func activate_reminder(text,wait_time = 0.01, wait_time_before_retraction = 6):
	print("(ON: reminder_ui.gd) START REMINDER TEXT")
	wait_timer.set_wait_time(wait_time)
	wait_timer.start()
	yield(wait_timer,"timeout")
	reminder_text.set_text(text)
	emit_signal("reminder_text_changed",text)
	anim.play("appear")
	
	wait_timer.set_wait_time(wait_time_before_retraction)
	wait_timer.start()
	yield(wait_timer,"timeout")
	anim.play("disapear")


func close():
	wait_timer.stop()
	wait_timer.set_wait_time(0.01)
	wait_timer.start()	