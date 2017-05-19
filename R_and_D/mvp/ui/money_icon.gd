#					ui_money_update
extends Node2D

func money_update(value,start_pos):
	set_global_pos(Vector2(start_pos.x,start_pos.y + 100))
	#update the poping coin
	get_node("anim_anchor/ui_money_update_img/Label").set_text(str(value))
	get_node("anim_anchor/money_update_anim").play("money_update_pop")
	