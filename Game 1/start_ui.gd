extends Control

@onready var time_left: Label = $CenterContainer/PanelContainer/VBoxContainer/TimeLeft


func _ready() -> void:
	get_tree().paused = true


func _process(delta: float) -> void:
	if Input.is_anything_pressed():
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			#score_ui.visible = true
			queue_free()
