extends Node

var musicProgress = 0.0


@onready var score := 0
@onready var high_score := 0
@onready var prev_high := 0


### Save Function Solutions ###

### Working, but simple save/load functionality, quite brittle approach (order of saving and loading must match-up). Not fit for exported project since 'res' becomes read-only at that point. ###
#func save():
	##var file = FileAccess.open("res://savegame.data", FileAccess.WRITE)
	##file.store_var(high_score)
	##file.close()
	#

#### JSON solution: produces a human-readable file, order of saving and loading doesn't matter, but requires manual handling of Godot's built-in data types, such as Vector2/Vector3. ###
#func save():
	##var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	### create dictionary
	##var saved_data = {}
	##
	### create dictionary elements
	##saved_data["score"] = score
	##saved_data["high_score"] = high_score
	##
	### convert dictionary to string
	##var json = JSON.stringify(saved_data)
	### store converted string to json file
	##file.store_string(json)

### Dictionary solution: order of saving and loading doesn't matter, native suipport for Godot built-in data types, but does not produce a human-readable file ###
#func save():
	##var file = FileAccess.open("user://savegame.data", FileAccess.WRITE)
	##
	### create dictionary
	##var saved_data = {}
	##
	### create dictionary elements
	##saved_data["score"] = score
	##saved_data["high_score"] = high_score
	##
	### store entire dictionary to file
	##file.store_var(saved_data)
	##file.close()

### Resource Solution: order of saving and loading doesn't matter, native support for Godot built-in data types, produces a human-readable file  ###
func save():
	### Resource Solution: ###
	var saved_game:SavedGame = SavedGame.new()
	
	# assign globals variables into resource variables.
	saved_game.score = score
	saved_game.high_score = high_score
	saved_game.prev_high = prev_high
	
	# built-in method for saving a resource to a file. '.tres' = text-based resource
	ResourceSaver.save(saved_game, "user://saved_game.tres")

### Load Function Solutions ### 

### Working, but simple save/load functionality, quite brittle approach (order of saving and loading must match-up). Not fit for exported project since 'res' becomes read-only at that point. ###
#func load():
	##var file = FileAccess.open("res://savegame.data", FileAccess.READ)
	##high_score = file.get_var()
	##file.close()

### JSON solution: produces a human-readable file, order of saving and loading doesn't matter, but requires manual handling of Godot's built-in types, such as Vector2/Vector3. ###
#func load():
	##var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	##
	### Grab the json string from the file. This reads the whole file into a string.
	##var json = file.get_as_text()
	##
	### Convert the json string back into a dictionary
	##var saved_data = JSON.parse_string(json)
	##
	### assign the loaded high_score value into the high_score variable
	##high_score = saved_data["high_score"]
	##
	##file.close()

### Dictionary solution: order of saving and loading doesn't matter, native suipport for Godot built-in data types, but does not produce a human-readable file ###
#func load():
	##var file = FileAccess.open("user://savegame.data", FileAccess.READ)
	##
	##var saved_data = file.get_var()
	### assign the loaded high_score value into the globals high_score variable
	##high_score = saved_data["high_score"]
	##
	##file.close()

### Resource Solution: order of saving and loading doesn't matter, native support for Godot built-in data types, produces a human-readable file  ###
func load():
	var saved_game:SavedGame = load("user://saved_game.tres") as SavedGame # <--- this is done to allow for autocomplete 
	
	# assign the loaded high_score value from the resource into the globals high_score variable
	high_score = saved_game.high_score
	prev_high = saved_game.prev_high
