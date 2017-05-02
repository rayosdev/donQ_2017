extends Area2D

 
var parent

var move_timer = Timer.new()

const speed_constraint = 0.05


func _ready():
	
	#	Sice all movment is acted on the parent node this gets the parent referance
	parent = get_parent()
	
	#	Setup the move_timer to be used in the steps of the move engine
	move_timer.set_one_shot(true)
	move_timer.set_wait_time(0.01)
	add_child(move_timer)


#	the move engine takes a array of Vector2 or a array of two celled arrays
func move_engine(target_positions):
	print("target_positions: @ %s " % str(target_positions))
	
	#	Sanatice for empty arrays
	if(target_positions[0] == null): return print("ERROR - NO ELEMENTS FOUND IN ARRAY @target_position") 
	
	#	Sanatice for other variables then arrays
	if(typeof(target_positions) != 21): return print("ERROR - FAILD TYPE @target_positions NOT AN ARRAY")
	
	#	If the first element is an two celled array convert all the items to Vector2
	if(typeof(target_positions[0]) == 21):
		var tmp_array = []
		for target_pos in target_positions: 
			if(target_pos.size() > 2): print("ERROR - @target_pos SIZE IS GREATER THEN A Vector2 ")
			else:
				tmp_array.append(Vector2(target_pos[0],target_pos[1]))
		target_positions = tmp_array
	
	#	Every Vector2 in target_posistions will be executed after turn
	for target_pos in target_positions:
		
	#	print("MOVE: %s" % str(target_position))
		
		
		#	Do a while loop until this position is equal to target position
		while(parent.get_pos() != target_pos):
			var parent_pos = parent.get_pos()
			
			#	Test if taget_pos and parent_pos is equal within a reasnble error margin
			#	...and then break the loop
			
#			print("MOVE STEP: %s" % str(parent_pos))
			
			#	Figure out the direction vector and constrain the speed
			var direction = (target_pos - parent_pos) * speed_constraint
			
			#	Simplefy the "_Utils._is_within_margins" statnent vasiables
			var xtest = [parent_pos.x,target_pos.x]
			var ytest = [parent_pos.y,target_pos.y]
			#	Margin is the constant movment for the direction and also the 
			#	..."_is_within_margins" margin test 
			var margin = 2
			var speed = margin
			
			#	Test to se if the parent.x is within the margin error of target_pos.x
			if(_Utils._is_within_margins(xtest[0], xtest[1] - margin, xtest[1] + margin)): 
				parent.set_pos(Vector2(target_pos.x,parent.get_pos().y))
			#	Else the constant speed is added to direction, this is to hinder 
			#	...slow speeds in the lerpt
			else: direction.x += speed * sign(direction.x)
			
			#	Test to se if the parent.y is within the margin error of target_pos.y
			if(_Utils._is_within_margins(ytest[0], ytest[1] - margin, ytest[1] + margin)): 
				parent.set_pos(Vector2(parent.get_pos().x,target_pos.y))
			#	Else the constant speed is added to direction, this is to hinder 
			#	...slow speeds in the lerpt
			else: direction.y += speed * sign(direction.y)
			
			#	Test to see if the move condition is reached
			if(parent.get_pos() == target_pos): break
			
			#	Move the parent in the right direction
			parent.set_pos(parent_pos + (direction))
			
			#	start the yield process
			move_timer.start()
			yield(move_timer,'timeout')
			
			
			
	#	- The array2_to_Vector2 takes 
func array2_to_Vector2(array2):
			if(array2.size() > 2): print("ERROR - @target_pos SIZE IS GREATER THEN A Vector2 ")
			else: return Vector2(array2[0],array2[1])

func array2_of_array_to_vector2_of_array(array):
	var tmp_array = []
	for array2 in array: tmp_array.append(array2_to_Vector2(array2))
	return tmp_array 