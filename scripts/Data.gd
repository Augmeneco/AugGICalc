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
	'anemo': 'Бонус Анемо урона',
	'cryo': 'Бонус Крио урона',
	'electro': 'Бонус Электро урона',
	'geo': 'Бонус Гео урона',
	'hydro': 'Бонус Гидро урона',
	'pyro': 'Бонус Пиро урона',
	'dendro': 'Бонус Анемо урона',
	'phys': 'Бонус Физ. урона',
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
