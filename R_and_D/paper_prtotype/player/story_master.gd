#					story_master.gd
extends Node

#	-- Story Resources --  
export (NodePath) var root_node


func _ready():
	if(root_node != null): root_node = get_node(root_node) 
	else: return print("ERROR - NODEPATH @root_node NOT FOUND IN: @%s" % get_name())
	
	