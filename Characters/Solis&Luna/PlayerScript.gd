extends CharacterBody3D
class_name Kairo_Traveller

#--- Player Settings
@export var ShiftToggleRun := true
@export var sens := 0.5

#--- Camera Movement
@onready var CamPivot: Node3D = $CamOrigin
@onready var Cam: Camera3D = $CamOrigin/SpringArm3D/Camera3D
@export var MouseLocked := false
@export var Move_Dir = Vector3.ZERO
@export var VisualNode: Node3D # Node Responsible for visualizing characters

var x_rot = 0
var y_rot = 0


#--- Movement
@onready var IdleTimer: Timer = $IdleTimer
@export var Speed = 0.0
@export var WalkSpeed = 3.0
@export var RunSpeed = .0
@export var JumpVel = 4.5
@export var KnockbackVel := Vector3.ZERO
@export var KnockbackDecel := 10.0
@export var Sprinting := false


#---- States
@export var CurrentState := 0
@export var States := ["Idle", "Walking", "Running", "Jumping", "Climbing", "Falling", "Mounted", "Attacking", "Stunned", "Buffer"]


#---- State Handlers
func handle_movement(input_dir: Vector2, delta):
	# --- Camera Relative Movement
	var cam_forward = -Cam.global_transform.basis.z
	var cam_right = Cam.global_transform.basis.x
	
	#--- Projecting directions onto XZ Plane and ignore vertical camera movement
	cam_forward.y = 0
	cam_right.y = 0
	
	#--- Movement Direction Relative to Camera
	Move_Dir = (cam_forward * -input_dir.y + cam_right * input_dir.x)
	Move_Dir.z = Move_Dir.z
	
	if Move_Dir:
		velocity.x = Move_Dir.x * Speed
		velocity.z = Move_Dir.z * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		velocity.z = move_toward(velocity.z, 0, Speed)
	
	#--- Face Character to Direction of Movement
	if Move_Dir:
		var target_rotation: Quaternion
		var current_roation = VisualNode.global_transform.basis.get_rotation_quaternion()
		target_rotation = Quaternion(Vector3.FORWARD, Move_Dir.normalized())
		
		var new_rotation = current_roation.slerp(target_rotation, 7.2 * delta)
		
		VisualNode.global_transform.basis = Basis(new_rotation)
	
	start_idleTimer()
	

#---- Utility Helper
func start_idleTimer():
	IdleTimer.start(20.0)

#---- Main Functions

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	MouseLocked = true


func _input(event):
	if event.is_action_pressed("Sprint") and not ShiftToggleRun and not CurrentState == 5:
		Sprinting = true
	
	elif event.is_action_released("Sprint") and not CurrentState == 5:
		if ShiftToggleRun:
			Sprinting = not Sprinting
		else:
			Sprinting = false
	
	if event is InputEventMouseMotion and MouseLocked:
		x_rot -= event.relative.x * sens
		y_rot -= event.relative.y  * sens
		
		y_rot = clamp(y_rot, -80, 60)
		CamPivot.rotation.x = deg_to_rad(y_rot)
		CamPivot.rotation.y = deg_to_rad(x_rot)

func _physics_process(delta):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveFront", "MoveBack")
	
	# Check for State Conversion
	
	CurrentState = 9 # Buffer Current State
	
	if input_dir:
		if Sprinting:
			CurrentState = 2
		else:
			CurrentState = 1
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		CurrentState = 3
	
	if not is_on_floor():
		CurrentState = 5
	


	# State Machine
	var State = States[CurrentState]
	match State:
		"Idle":
			CurrentState = 9
			# TODO: Play Idle Anim
		
		"Walking":
			Speed = WalkSpeed
		
		"Running":
			Speed = RunSpeed
		
		"Jumping":
			velocity.y = JumpVel
			print("Jump")
		
		"Climbing":
			pass
		
		"Falling":
			velocity += get_gravity() * delta
			print("Fall")
	

	# Velocity
	handle_movement(input_dir, delta)
	
	# Knockback
	velocity += KnockbackVel
	KnockbackVel = KnockbackVel.move_toward(Vector3.ZERO, KnockbackDecel * delta)
	

	move_and_slide()


func _Knockback(knockbackVelocity, knockbackDecel):
	KnockbackVel = knockbackVelocity
	KnockbackDecel = knockbackDecel


func Idle():
	CurrentState = 0
	start_idleTimer()
