class_name  Sandbox extends Node3D
const obstacle_x_pos := 9
const floor_end_x_pos := -12.5


@onready var obstacle := preload("res://Obstacles/obstacle_pair.tscn")
@onready var obstacle_spawner: Timer = $Obstacle_Spawner
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio_stream_player.play(Globals.musicProgress)
	if FileAccess.file_exists("user://saved_game.tres"):
		Globals.load()

func spawn_obstacle() -> void:
		var new_obstacle = obstacle.instantiate()
		add_child(new_obstacle)
	
		var y_pos = randf_range(-1.5 , 1.5)
		new_obstacle.global_position = Vector3(obstacle_x_pos,y_pos, 0)


func on_floor_hit(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.died.emit()
