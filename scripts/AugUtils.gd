extends Node

#func _ready():
#	pass # Replace with function body.

static func readFile(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
static func saveFile(path, content):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()
	
static func listdir(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."): # and not file.ends_with(".import")
			files.append(file.replace('.import',''))
	dir.list_dir_end()
	return files
	
static func text_from_quot(text):
	var regex = RegEx.new()
	regex.compile('"([^"]*)"')
	return regex.search_all(text)[0].get_string(1)
