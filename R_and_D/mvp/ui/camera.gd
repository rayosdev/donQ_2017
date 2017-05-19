extends Camera2D

var root_node
var player
var init_follow_player
var view_finder
var follow = false
var follow_targets = []
var mouse_cilck_area

func _ready():
	
	root_node 			= get_tree().get_current_scene()
	player 				= root_node.find_node("player")
	view_finder			= get_parent()
	init_follow_player	= get_node("init_follow_player")
	init_follow_player.connect("area_enter",self,"set_camera_to_follow")
	set_process(true)
	
	mouse_cilck_area = get_node("mouse_click_area")
	mouse_cilck_area.connect("pressed",player,"_on_mouse_click_area_button_down")

func set_camera_to_follow(area):
	if(area.get_groups().has("player")):
		follow_targets.append(player)
		follow =true


func _process(delta):
	if(follow == false): return
	view_finder.set_pos(follow_targets[0].get_pos())
	