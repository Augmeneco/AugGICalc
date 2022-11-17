extends HBoxContainer

export var element: String
export var text: String

signal button_clicked(element)

func _ready():
	$TextureRect.texture = load('res://images/icons/element_%s.webp' % element)
	$PassiveName.text = text
	pass 


func _on_CheckButton_pressed():
	emit_signal('button_clicked', element)
	pass 
