extends Node2D

func _ready():
	OS.set_window_maximized(true)
	init_main_stats()
	
	Data.character = $Control/Control/HBoxContainer/RightTab/Character
	Data.weapon = $Control/Control/HBoxContainer/RightTab/Weapon
	
	Data.character.add_buffs(Data.weapon.stat)
	
	$Control/Control/HBoxContainer/RightTab/Character.calculate_stats()

func _process(delta):
	var viewport_base_size := (
		get_viewport().get_size_override() if get_viewport().get_size_override() > Vector2(0, 0)
		else get_viewport().size
	)
	
	if viewport_base_size != $Control.rect_size:
		$Control.rect_size = viewport_base_size

func init_main_stats():
	var container: VBoxContainer = $Control/Control/HBoxContainer/LeftTab/CharStats/VBoxContainer/
	var container_category = [
		$Control/Control/HBoxContainer/LeftTab/CharStats/VBoxContainer/MainStatContainer,
		$Control/Control/HBoxContainer/LeftTab/CharStats/VBoxContainer/SecondStatContainer,
		$Control/Control/HBoxContainer/LeftTab/CharStats/VBoxContainer/ElementsContainer
	]
	var stats_category = [
		['hp','atk','def','em'],
		['re','cr','cd'],
		['anemodmg','cryodmg','electrodmg','geodmg','hydrodmg','pyrodmg','dendrodmg','physdmg']
	]
	var char_stat_prefab = load('res://prefabs/CharMainStats.tscn')
	
	for category in range(len(stats_category)):
		stats_category[category].invert()
		for stat in stats_category[category]:
			Data.char_stats_gui[stat] = char_stat_prefab.instance()
			Data.char_stats_gui[stat].icon = stat
			Data.char_stats_gui[stat].stat_name = Data.stats_enum[stat]
			Data.char_stats_gui[stat].stat_value = 0
			
			container.add_child_below_node(
				container_category[category],
				Data.char_stats_gui[stat]
			)
			
func re_draw_stats():
	#for Data.character.stats
	pass

	
func _on_WeaponTab_pressed():
	$Control/Control/HBoxContainer/RightTab.current_tab = 1

func _on_CharacterTab_pressed():
	$Control/Control/HBoxContainer/RightTab.current_tab = 0
