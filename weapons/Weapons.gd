extends TabContainer

var atk: int
var stat: Dictionary
#var buffs: Dictionary

var weapons_list: Array
var weapon_obj: Dictionary

var stat_nums_format_regex = RegEx.new()

func _ready():
	weapons_list = JSON.parse(AugUtils.readFile('res://weapons/weapons.json')).result
	weapon_obj = weapons_list[2]
	
	stat_nums_format_regex.compile("\\[(\\D+?)\\]")
	
	init_weapon()
	init_gui()
	
	
func init_weapon():
	$Control/WeaponImage.texture = load('res://images/weapons/catalyst/%s.png' % weapon_obj['image'])
	$Control/WeaponName.text = weapon_obj['name']
	
	atk = weapon_obj['atk']
	stat = weapon_obj['stat']
	
	if weapon_obj['rarity'] == 4:
		$Control/Stars/TextureRect5.hide()
	else: $Control/Stars/TextureRect5.show()
	
	var stat_text = ''
	if weapon_obj['stat'].keys()[0] in ['em']:
		stat_text += str(weapon_obj['stat'].values()[0])
	else:
		stat_text += '%s%%' % (weapon_obj['stat'].values()[0]*100)
		
	$Control/WeaponStatsLabel.bbcode_text = '[color=#beaea9]%s[/color] %s\n[color=#beaea9]%s[/color] %s' % \
		[Data.stats_enum['atk'], weapon_obj['atk'], Data.stats_enum[weapon_obj['stat'].keys()[0]], stat_text ]


func stat_nums_format(text: String, stats: Dictionary):
	var result = stat_nums_format_regex.search_all(text)
	for _stat in result:
		var stat_name = _stat.get_string(1)
		
		if stat_name in ['em','atk_flat','def_flat','hp_flat','flatdmg']:
			text = text.replace('[%s]'%stat_name, 
				'[color=white]%s[/color]'%stats[stat_name])
		else:
			text = text.replace('[%s]'%stat_name, 
				'[color=white]%s[/color]'%(str(stats[stat_name]*100)+'%'))
			
	text = '[color=#beaea9]%s[/color]' % text
	
	return text


func init_gui():
	var passives_list: BoxContainer = $Control/ScrollContainer/PassivesList
	var talent_panel_prefab = load('res://prefabs/PassivePanel.tscn')
	var passive_button_prefab = load('res://prefabs/PassiveToggleButton.tscn')
	
	for passive in weapon_obj['gui']:
		var talent_panel = talent_panel_prefab.instance()
		#Настраиваем панель
		talent_panel.get_node('VBoxContainer/TextContainer/PassiveText').bbcode_text = \
			stat_nums_format(passive['desc'], passive['buff'])
		talent_panel.get_node('VBoxContainer/NameContainer/PassiveName').text = \
			passive['name']
				
		if passive['type'] == 'toggle':
			var passive_button = passive_button_prefab.instance()
			
			talent_panel.get_node('VBoxContainer/Buttons').add_child(passive_button)
			passive_button.get_node('PassiveName').text = passive['name']
			passive_button.get_node('CheckButton').connect(
				'toggled', self, 'buff_toggle_pressed', [passive['buff']])
			
			#Прячем основное имя ибо кнопка
			talent_panel.get_node('VBoxContainer/NameContainer/PassiveName').hide()
		
		if passive['type'] == 'none':
			talent_panel.get_node('VBoxContainer/Buttons').hide()
			
		passives_list.add_child(talent_panel)
	pass
	
	
func buff_toggle_pressed(pressed: bool, buffs: Dictionary):
	Data.character.add_buffs(buffs, pressed)
			
