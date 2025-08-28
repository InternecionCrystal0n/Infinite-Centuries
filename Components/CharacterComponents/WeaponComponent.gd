extends Node
## Handles the basic attacks for weapons
class_name WeaponComponent

@export var SpecialWeaponHandler : SpecialWeapon
@export var CDTimer : Timer
@export var ComboResetTimer : Timer

#-------------------------------------------------

@export var Combo := 0
@export var MaxCombo := 2 ## Count starts from zero.

@export var OnCD := false
@export var CD_Durations : Array[float]
@export var ComboReset_Duration : Array[float]

@export var BlockAngle := 45

# Ready
func _ready():
	if CDTimer:
		CDTimer.connect("timeout", CDTimeout)
	if ComboResetTimer:
		ComboResetTimer.connect("timeout", ComboResetTimeout)

func CDTimeout():
	OnCD = false
	

func ComboResetTimeout():
	Combo = 0
	

# Utility Functions

# Main
func _attack():
	if OnCD: return
	
	# Handle CD
	CDTimer.start(CD_Durations[Combo])
	ComboResetTimer.start(ComboReset_Duration[Combo])
	
	if Combo >= MaxCombo:
		Combo = 0
	else:
		Combo += 1
	print(Combo)
	
