extends CharacterBody2D


@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var kick_back: float = 300.0
@export var drag: float = 3.0
@export var energy_cost: float = 10.0

var animation_player: AnimationPlayer

var is_shooting: bool = false

var last_direction: Vector2 = Vector2(1, 0)
var left_right: String = "Left"
var last_direction_word: String = "Left"


func _ready():
	animation_player = $AnimationPlayer


func _physics_process(delta):
	var direction = get_direction()
	if not animation_player.is_playing():
		is_shooting = false
	if not is_shooting:
		if is_on_floor():
			handle_floor_movement(direction)
		else:
			handle_air_movement(delta, direction)
	if Input.is_action_just_pressed("shoot") and Globals.energy >= energy_cost:
		handle_shooting()

	move_and_slide()

	
func handle_floor_movement(direction):
	if Input.is_action_just_pressed("up"):
		velocity.y = jump_velocity

	if direction.x:
		velocity.x = direction.x * speed
		animation_player.play("Walking" + left_right)
	else:
		animation_player.play("Standing" + left_right)
		velocity.x = 0

	
func handle_air_movement(delta, direction):
	animation_player.play("Airborne" + left_right)
	velocity += get_gravity() * delta
	var delta_v = direction.x * speed - velocity.x
	velocity.x += delta_v * drag * delta

func handle_shooting():
	Globals.energy -= energy_cost
	is_shooting = true
	if last_direction.y == 0:
		animation_player.play("Shooting" + left_right)
	else:
		animation_player.play("Shooting" + last_direction_word + left_right)
	# todo: spawn a projectile
	velocity.y = 0
	velocity += kick_back * last_direction * -1


func get_direction() -> Vector2:
	var direction: Vector2 = Vector2(0, 0)
	if Input.is_action_pressed("down"):
		direction.x = 0
		direction.y = 1
		last_direction = direction
		last_direction_word = "Down"
	elif Input.is_action_pressed("right"):
		direction.x = 1
		direction.y = 0
		last_direction = direction
		last_direction_word = "Right"
		left_right = "Right"
	elif Input.is_action_pressed("left"):
		direction.x = -1
		direction.y = 0
		last_direction = direction
		last_direction_word = "Left"
		left_right = "Left"
	elif Input.is_action_pressed("up"):
		direction.x = 0
		direction.y = -1
		last_direction = direction
		last_direction_word = "Up"
	
	return direction
