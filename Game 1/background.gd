extends CSGBox3D

@export var end_POS := Vector3(-12.5, 5, -1)
@export var start_POS:= Vector3(12.5, 5, -1)

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if global_position == start_POS:
		var tween = create_tween()
		tween.tween_property(self, "position", end_POS, 20).set_trans(Tween.TRANS_LINEAR)
	if global_position == end_POS:
		global_position = start_POS
