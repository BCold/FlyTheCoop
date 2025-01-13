extends ParallaxBackground

@export var scrollSpeedX = 15
@export var scrollSpeedY = 15
@export var bgTexture: CompressedTexture2D = preload("res://Assets/bg/Blue.png")
@onready var sprite = $ParallaxLayer/Sprite2D

func _ready():
	sprite.texture = bgTexture

func _process(delta):
	sprite.region_rect.position += delta * Vector2(scrollSpeedX, scrollSpeedY)
	if sprite.region_rect.position >= Vector2(64,64):
		sprite.region_rect.position = Vector2.ZERO
