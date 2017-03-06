extends VBoxContainer

var sample_player 

func _ready():
	sample_player = get_node("sample_player")
	pass



func _on_pickup_pressed():
	sample_player.play("pickup")


func _on_lose_money_pressed():
	sample_player.play("lose money")
