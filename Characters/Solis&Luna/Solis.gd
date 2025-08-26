extends CharacterBody3D

var speed = 5.0
const JUMP_VELOCITY = 4.5
@onready var Pivot = $CamOrigin
@export var Sensitivity = 0.5
@export var MouseLocked = true
@export var GameplayMenuMouseLock = false # Fixes Bug if Player Needs to use Menu in a Gameplay Menu
@export var knockbackVelocity: Vector3 = Vector3.ZERO

@export var Health: HealthComponent
@export var WeaponComp : WeaponComponent

@export var Blocking := false
@export var Sprinting := false
@export var Crouching := false
@export var Swimming := false
@export var Attacking := false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	MouseLocked = true
	

func _input(event):
	if event is InputEventMouseMotion and MouseLocked:
		rotate_y(deg_to_rad(-event.relative.x * Sensitivity))
		Pivot.rotate_x(deg_to_rad(-event.relative.y * Sensitivity))
		Pivot.rotation.x = clamp(Pivot.rotation.x, deg_to_rad(-90), deg_to_rad(65))
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("Menu"):
		if not GameplayMenuMouseLock:
			MouseLocked = not MouseLocked
			if MouseLocked:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		# TODO: Show the menu

	# Handle Block.
	if Input.is_action_just_pressed("Block"):
		Blocking = true
		#Health.HealthControl = 0.1
	
	if Input.is_action_just_released("Block"):
		Blocking = false
		#Health.HealthControl = 1.0
	
	# Handle Attack.
	if Input.is_action_just_pressed("Attack"):
		WeaponComp.attack()
	

	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveFront", "MoveBack")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	#Knockback
	velocity += knockbackVelocity
	knockbackVelocity = knockbackVelocity.move_toward(Vector3.ZERO, delta * 20.0)

	move_and_slide()
