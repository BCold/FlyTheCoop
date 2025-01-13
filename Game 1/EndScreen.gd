extends Control

@onready var score: Label = $CenterContainer/PanelContainer/VBoxContainer/Score
@onready var high_score: Label = $CenterContainer/PanelContainer/VBoxContainer/HighScore
@onready var new_high_score: Label = $CenterContainer/PanelContainer/VBoxContainer/NewHighScore
@onready var high_score_audio: AudioStreamPlayer = $HighScore
@onready var retry_button: Button = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer/RetryButton

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	retry_button.grab_focus()
	if Globals.high_score > Globals.prev_high:
		high_score_audio.play()
		new_high_score.text = str("New Hi-Score!\n", Globals.high_score)
		new_high_score.visible = true
		high_score.visible = false
		score.visible = false
		Globals.prev_high = Globals.high_score
	else:
		score.text = str("Score ", Globals.score)
		high_score.text = str("Hi-Score ", Globals.high_score)
	
	Globals.save()
	print(Globals.prev_high)

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Retry"):
		#var audioPlayer: AudioStreamPlayer = get_tree().get_first_node_in_group("persistentAudio") as AudioStreamPlayer
		#print(audioPlayer)
		#Globals.musicProgress = audioPlayer.get_playback_position()
		#get_tree().reload_current_scene()
		#Globals.score = 0
		#Engine.time_scale = 1
		#
	#elif Input.is_action_just_pressed("Quit"):
		#get_tree().quit()

func _on_retry_button_pressed() -> void:
	var audioPlayer: AudioStreamPlayer = get_tree().get_first_node_in_group("persistentAudio") as AudioStreamPlayer
	print(audioPlayer)
	Globals.musicProgress = audioPlayer.get_playback_position()
	get_tree().reload_current_scene()
	Globals.score = 0
	Engine.time_scale = 1

func _on_quit_button_pressed() -> void:
	get_tree().quit()
