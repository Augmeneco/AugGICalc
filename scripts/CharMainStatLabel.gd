extends BoxContainer

export var icon: String
export var stat_name: String
export var stat_value: String

func _ready():
	init_stat(icon, stat_name, stat_value)
	pass 

func init_stat(icon: String, name: String, value: String):
	#$IconImage.texture = ImageTexture.new()
	$IconImage.texture = Data.images['stats'][icon]
	$NameLabel.text = name
	$StatLabel.text = value
	pass
	
func update_stat(value: float):
	if icon in ['atk','def','hp','em']:
		$StatLabel.text = str(value)
	else:
		$StatLabel.text = str(value*100)+'%'
