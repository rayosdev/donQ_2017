#		grav_pull += grav
#		vel.y += grav_pull
#		if(get_pos().y >= ground_pos):
#			vel = vel / 2
#			vel.y = -vel.y
#			grav_pull = 0
#		set_pos(get_pos() + vel)
		
#		if(get_pos().y > (ground_pos - vel.y)):
#			print("vel: " + str(vel))
#			print("grave_pull: " + str(grav_pull))
#			vel.x = vel.x - (vel.x / 2)
#			vel.y = (vel.y - ((grav_pull / 2) * ground_fric))
#			vel.y = -vel.y
#			grav_pull = 0
#			print("vel-: " + str(vel))
#		else:
#			grav_pull += grav
#			vel.y += grav_pull
#		
#		set_pos(get_pos() + vel)
#		
#		vel = vel - (vel * fric) # this is a Lerp 
#		if(Input.is_action_pressed("ui_right")):vel.x += 2
#		if(Input.is_action_pressed("ui_left")):vel.x -= 2
#		if(Input.is_action_pressed("ui_up")):vel.y -= 2
#		if(Input.is_action_pressed("ui_down")):vel.y += 2
#		print(get_pos())