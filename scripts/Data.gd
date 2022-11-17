extends Node

var character
var weapon

var stats_enum = {
	'hp': 'HP',
	'atk': 'Сила атаки',
	'def': 'Защита',
	'em': 'Мастерство стихий',
	're': 'Восст. энергии',
	'cr': 'Шанс крит. попадания',
	'cd': 'Крит. урон',
	'anemodmg': 'Бонус Анемо урона',
	'cryodmg': 'Бонус Крио урона',
	'electrodmg': 'Бонус Электро урона',
	'geodmg': 'Бонус Гео урона',
	'hydrodmg': 'Бонус Гидро урона',
	'pyrodmg': 'Бонус Пиро урона',
	'dendrodmg': 'Бонус Анемо урона',
	'physdmg': 'Бонус Физ. урона',
}

var images = {
	'stats': {
		
	}
}

var char_stats_gui = {
	
}

func _ready():
	init_stat_icons()
	
	pass

func init_stat_icons():
	var files = AugUtils.listdir('res://images/icons/stats')

	for stat in stats_enum:
		images['stats'][stat] = load('res://images/icons/stats/'+stat+'.png')
	pass
