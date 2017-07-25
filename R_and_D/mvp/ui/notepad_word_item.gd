extends Container

#		Refrances
var sound_btn
var translation_field
var check_btn
var spanish_word_label

func _ready():
	#		Setup Refrances
	sound_btn			= get_node("hbox_contian/soud_btn")
	translation_field	= get_node("hbox_contian/CenterContainer/translation_field")
	check_btn			= get_node("hbox_contian/check_btn")
	spanish_word_label	= get_node("hbox_contian/spanish_word/label")
