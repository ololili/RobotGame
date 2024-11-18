extends Area2D

signal button_pressed

@export var is_main_button: bool = false
@export var max_timer: float = 60.0

var sprite: Sprite2D
var is_down: bool = false

func _ready():
	sprite = $sprite_2d
	if is_main_button:
		Globals.max_timer = max_timer
		Globals.timer = max_timer


func _process(_delta):
	if is_main_button and is_down and not Globals.is_timing:
		reset_button()

func reset_button():
	is_down = false
	sprite.frame = 0


func _on_body_entered(body):
	if body.name == "robot" and not is_down:
		$audio_stream_player.play()
		button_pressed.emit()
		is_down = true
		sprite.frame = 1
		if is_main_button:
			Globals.start_timer()
