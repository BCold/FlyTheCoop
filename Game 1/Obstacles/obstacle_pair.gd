class_name ObstaclePair extends Node3D

@export var speed := 0.5
var end_screen = load("res://end_screen.tscn").instantiate()
#var new_end_screen = end_screen.instantiate()
@onready var label_3d: Label3D = $ScoreArea/Label3D
@onready var scored_audio: AudioStreamPlayer3D = $ScoreArea/scoredAudio


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta


func on_screen_exited() -> void:
	if global_position.x < 0:
		queue_free()


func on_killzone_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.died.emit()
		body.reparent(self)
		#killed.play()
		#get_tree().paused = true
		#get_tree().current_scene.add_child(new_end_screen)
		#new_end_screen.visible = true



#func on_score_area_exit(body: Node3D) -> void:
	#if body is CharacterBody3D:
		#scored.emit()
		#Globals.score += 1
		#print("Score: ", Globals.score)
		#if Globals.score > Globals.high_score:
			#Globals.high_score = Globals.score



func player_scored(body: Node3D) -> void:
	if body is CharacterBody3D:
		scored_audio.play()
		label_3d.visible = true;
		var tween = create_tween()
		tween.tween_property(label_3d, "position", Vector3(0, 0.5, 0), 1).set_trans(Tween.TRANS_LINEAR)
		if label_3d.global_position.y == 0.8:
			label_3d.queue_free()
		body.scored.emit()
