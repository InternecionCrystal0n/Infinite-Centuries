extends Node
## Base Executive Class for handling extra weapon functions
class_name SpecialWeapon

@export var HealthComp : HealthComponent
@export var StunComp : StunComponent
@export var KnockbackComp : KnockbackComponent
@export var Entity : CharacterBody3D

func handle_attack():
	pass

func handle_block():
	pass

func handle_stun():
	pass

func handle_knockback():
	pass
