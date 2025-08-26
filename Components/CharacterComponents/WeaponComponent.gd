extends Node3D
## Weapon Handler Component
class_name WeaponComponent

@export var Combo := 0
@export var MaxCombo := 2 # Index Type - Variable Starts from Zero so basically max combo 3 is 2
@export var AnimPlayer : AnimationPlayer
@export var WeaponName : String
@export var Attacks : Array[Attack]

@export var BlockAngle := 45.0
@export var WeaponCds : Array[float] ## Weapon Cooldown for each combo
@export var onCD := false

@export var WeaponNode : Weapon

@export var CDTimer: Timer
@export var CDResetTimer: Timer

# Initialization
func _ready():
	CDTimer.connect("timeout", CD_end)
	CDResetTimer.connect("timeout", CD_reset)


# Utility Helper Functions
func _create_hurtbox(atk: Attack):
	var hurtbox = HurtboxComponent.new()
	var atkInst = atk.duplicate()
	


# Called Functions / Main

func attack():
	if onCD: return
	var animName = WeaponName + "/Combo_" + str(Combo)
	
	print(animName)
	print(Combo)
	AnimPlayer.play(animName)
	# Handle CD
	onCD = true
	CDTimer.start(WeaponCds[Combo])
	CDResetTimer.start(WeaponCds[Combo] * 1.7)
	
	if Combo == MaxCombo:
		Combo = 0
	else:
		Combo += 1
	



func CD_end():
	onCD = false
	

func CD_reset():
	Combo = 0
