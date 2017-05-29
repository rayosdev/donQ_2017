#					camera.gd
extends Camera2D

var root_node
var player
var init_follow_player
var view_finder
var follow = false
var follow_targets = []
var lerp_follow = true


func _ready():
	
	root_node 			= get_tree().get_current_scene()
	player 				= root_node.find_node("player")
	view_finder			= get_parent()
	init_follow_player	= get_node("init_follow_player")
	init_follow_player.connect("area_enter",self,"set_camera_to_follow")
	set_process(true)


func set_camera_to_follow(area):
	if(area.get_groups().has("player")):
		follow_targets.append(player)
		follow =true


func _process(delta):
	if(follow == false): return
	var ft 	= follow_targets[0].get_pos()
	var vfp = 		view_finder.get_pos()
	if(ft - vfp < Vector2(2,2)): lerp_follow = false
	
	if(lerp_follow): view_finder.set_pos(Vector2(	lerp(vfp.x,ft.x,0.07),	lerp(vfp.y,ft.y,0.07)	))
	else: view_finder.set_pos(ft)