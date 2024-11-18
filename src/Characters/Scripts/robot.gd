extends CharacterBody2D

@export_group("movement")
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var kick_back: float = 300.0
@export var drag: float = 3.0
@export_group("shooting")
@export var energy_cost: float = 10.0
@export var projectile_speed: float = 300
@export var recharge_rate: float = 10.0

var projectile
var animation_player: AnimationPlayer

var is_shooting: bool = false

var last_direction: Vector2 = Vector2(-1, 0)
var left_right: String = "Left"
var up_down: String = "Up"


func _ready():
	Globals.recharge_rate = recharge_rate
	projectile = load("res://src/Characters/projectile.tscn") as PackedScene
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
			handle_shooting(direction)

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
	
	var delta_v = Vector2(0, 0)
	delta_v.x = direction.x * speed - velocity.x
	delta_v.y = max(direction.y, 0) * speed - velocity.y
	velocity += delta_v * drag * delta

func handle_shooting(direction):
	$audio_stream_player.play()
	Globals.energy -= energy_cost
	is_shooting = true
	if direction.y == 0:
		animation_player.play("Shooting" + left_right)
		direction = last_direction
	else:
		animation_player.play("Shooting" + up_down + left_right)
	instantiate_projectile(direction)
	velocity.y = 0
	velocity += kick_back * direction * -1
	

func instantiate_projectile(direction):
	var new_projectile = projectile.instantiate()
	get_parent().add_child(new_projectile)
	var pos = global_position + direction * 4
	new_projectile.global_position = pos
	new_projectile.start(direction, projectile_speed)


func get_direction() -> Vector2:
	var direction: Vector2 = Vector2(0, 0)
	if Input.is_action_pressed("down"):
		direction.x = 0
		direction.y = 1
		up_down = "Down"
	elif Input.is_action_pressed("right"):
		direction.x = 1
		direction.y = 0
		last_direction = direction
		left_right = "Right"
	elif Input.is_action_pressed("left"):
		direction.x = -1
		direction.y = 0
		last_direction = direction
		left_right = "Left"
	elif Input.is_action_pressed("up"):
		direction.x = 0
		direction.y = -1
		up_down = "Up"
	
	return direction
