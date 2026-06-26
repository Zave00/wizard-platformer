extends CharacterBody2D

@export var jump_force: int = 500
@export var gravity: int = 2000
@export var move_speed: int = 300
@export var dashing_speed: int

var has_air_step: bool = false
var jump_count: int = 0
var direction: Vector2
var has_combustion: bool = false
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.RIGHT
var has_dashed: bool = false


func _ready() -> void:
	$DashLength.timeout.connect(stop_dash)

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	
func get_input():
	direction = Input.get_vector("left", "right", "up", "down")
	direction.normalized()
	if Input.is_action_just_pressed("jump"):
		if has_air_step == true:
			if jump_count == 0:
				if is_on_floor():
					velocity.y -= jump_force
					jump_count = 1
				else:
					velocity.y = 0
					velocity.y -= jump_force
					jump_count = 2
			elif jump_count == 1:
				velocity.y = 0
				velocity.y -= jump_force
				jump_count = 2
		else:
			if is_on_floor():
				velocity.y -= jump_force
	if has_combustion:
		if Input.is_action_just_pressed("dash") and not has_dashed and $DashCooldown.time_left <= 0:
			velocity = Vector2.ZERO
			is_dashing = true
			$DashLength.start()
			$DashCooldown.start()
			jump_count = 1
		 
		
func _physics_process(delta: float) -> void:
	get_input()
	if direction:
		dash_direction = direction;
	if is_dashing:
		if dash_direction == Vector2.UP or dash_direction == Vector2.DOWN:
			velocity = dash_direction * dashing_speed / 2
		elif dash_direction.y == 0:
			velocity = dash_direction * dashing_speed
		else:
			velocity = dash_direction * dashing_speed / 1.5
	else:
		velocity.x = direction.x * move_speed
		apply_gravity(delta)
	if is_on_floor():
		jump_count = 0
		has_dashed = false
	move_and_slide()


func stop_dash() -> void:
	is_dashing = false
	has_dashed = true
