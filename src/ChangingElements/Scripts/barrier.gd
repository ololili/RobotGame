extends StaticBody2D

var is_broken: bool = false
var collision: CollisionShape2D
var sprite: Sprite2D

func _ready():
	collision = $collision_shape_2d
	sprite = $sprite_2d
	Globals.timer_started.connect(reset_door)

func break_door():
	$audio_stream_player.play()
	collision.disabled = true
	sprite.frame = 1

func reset_door():
	collision.disabled = false
	sprite.frame = 0
