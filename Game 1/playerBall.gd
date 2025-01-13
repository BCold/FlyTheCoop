extends CharacterBody3D

signal died
signal scored

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
var player_died: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var end_screen = load("res://end_screen.tscn").instantiate()
@onready var player: CharacterBody3D = $"."
@onready var died_audio: AudioStreamPlayer3D = $died
@onready var cluck: AudioStreamPlayer3D = $cluck
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var cluck_timer: Timer = $cluck_timer


func _ready() -> void:
	cluck_timer.wait_time = randf_range(2.0, 8.0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Check whether player is dead
	if !player_died:
		# Handle jump.
		if Input.is_action_just_pressed("boost"):
			velocity.y = JUMP_VELOCITY
			animated_sprite_3d.play("flying")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_player_died() -> void:
	player_died = true
	process_mode = Node.PROCESS_MODE_DISABLED
	Engine.time_scale = 0.25
	audio_stream_player.pitch_scale = 0.7
	print("You died!")
	#get_tree().paused = true
	#if not animated_sprite_3d.is_playing():
	animated_sprite_3d.play("damaged")
	#await get_tree().create_timer(0.5).timeout
	#queue_free()
	died_audio.play()
	get_tree().current_scene.add_child(end_screen)
	end_screen.visible = true


func _on_cluck_timeout() -> void:
	cluck.play(randf_range(0.0, 1.0))
	cluck_timer.wait_time = randf_range(2.0, 8.0)
