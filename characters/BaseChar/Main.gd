extends Control

class Character:
	var name: String = 'Странник'
	var system_name: String = 'BaseChar'
	var image: String = 'wanderer'
	var element: String = 'anemo'
	var rarity: int = 5
	var id: int = 10000075
	
	var base_stats = {
		'hp': 10164,
		'atk': 328,
		'def': 607,
		'cr': 0.242,
		'cd': 0.5
	}
	
	var talents: Dictionary
	
	var bonuses = {
		'atk': 0, 'atk_flat': 0, 'def': 0, 'def_flat':0, 'hp': 0, 'hp_flat': 0, 'em': 0, 're': 0,
		'cr': 0, 'cd': 0, 'flatdmg': 0, 'alldmg': 0, 'normaldmg': 0, 'chargedmg': 0, 'plungedmg': 0,
		'skilldmg': 0, 'burstdmg': 0, 'pyrodmg': 0, 'cryodmg': 0, 'hydrodmg': 0, 'geodmg': 0,
		'dendrodmg': 0, 'electrodmg': 0, 'physdmg': 0
	}
	
	var stats = {
		'atk': 0, 'def': 0, 'hp': 0, 'em': 0, 're': 0,
		'cr': 0, 'cd': 0, 'alldmg': 0, 'normaldmg': 0, 'chargedmg': 0, 'plungedmg': 0,
		'skilldmg': 0, 'burstdmg': 0, 'pyrodmg': 0, 'cryodmg': 0, 'hydrodmg': 0, 'geodmg': 0,
		'dendrodmg': 0, 'electrodmg': 0, 'physdmg': 0
	}
	
	func _init():
		talents = JSON.parse(AugUtils.readFile('res://characters/%s/config.json' % system_name)).result
		pass

var character: Character

func _ready():
	character = Character.new()
	init_gui()
	init_character()
	pass 

func init_character():
	$Control2/CharName.text = character.name
	$Control2/CharAvatar.texture = load('res://images/chars/%s.png' % character.image)

func init_gui():
	var passives_list: BoxContainer = $Control2/ScrollContainer/PassivesList
	var talents_obj = character.talents
	var talent_panel_prefab = load('res://prefabs/PassivePanel.tscn')
	var passive_button_prefab = load('res://prefabs/PassiveToggleButton.tscn')
	var elemental_button_prefab = load('res://prefabs/ElementalButton.tscn')
	
	var talents_list = [
		talents_obj['talent1'], talents_obj['talent2'], talents_obj['talent3'], 
	] + talents_obj['passives']
	
	for talent in talents_list:
		if 'gui' in talent:
			for passive in talent['gui']:
				var talent_panel = talent_panel_prefab.instance()
				#Настраиваем панель
				talent_panel.get_node('VBoxContainer/TextContainer/PassiveText').bbcode_text = \
					passive['desc']
				talent_panel.get_node('VBoxContainer/NameContainer/PassiveName').text = \
					talent['name']
				
				if passive['type'] == 'toggle':
					var passive_button = passive_button_prefab.instance()
					
					talent_panel.get_node('VBoxContainer/Buttons').add_child(passive_button)
					passive_button.get_node('PassiveName').text = talent['name']
					#passive_button.get_node('CheckButton') сделать сигнал
					
					#Прячем основное имя ибо кнопка
					talent_panel.get_node('VBoxContainer/NameContainer/PassiveName').hide()
					
				if passive['type'] == 'elements_toggle':
					for element in passive['elements_toggle']:
						var elem_button = elemental_button_prefab.instance()
						elem_button.text = ''
						elem_button.element = element
						
						talent_panel.get_node('VBoxContainer/Buttons').add_child(elem_button)
				
				passives_list.add_child(talent_panel)
				

func calculate_stats():
	add_buffs(Data.weapon.stat)
	
	character.stats['atk'] = (character.base_stats['atk'] + Data.weapon.atk) * \
		(1+character.bonuses['atk']) + character.bonuses['atk_flat']
	
	print(character.stats)
	
	for stat in character.stats:
		if stat in Data.char_stats_gui:
			Data.char_stats_gui[stat].update_stat(character.stats[stat])
	pass

func add_buffs(buffs: Dictionary, add: bool = true):
	for buff in buffs:
		if add:
			Data.character.character.bonuses[buff] += buffs[buff]
		else:
			Data.character.character.bonuses[buff] -= buffs[buff]
	
	calculate_stats()
	pass
