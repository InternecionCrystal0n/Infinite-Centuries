extends Area3D
class_name HurtboxComponent

@export var health_comp : HealthComponent
@export var knockback : KnockbackComponent
@export var stun : StunComponent
@export var weapon : WeaponComponent
@export var entity : CharacterBody3D

func handle_hit(attack: Attack, HitObject: Area3D):
	# Handle the blocking
	if entity.Blocking and attack.isBlockable:
		var origin = entity.global_transform.origin
		var dir = entity.global_transform.basis.z
		var block_angle = weapon.BlockAngle
		
		
		return
	
	# Punish Entity for Blocking an Unblockable attack.
	elif entity.Blocking and not attack.isBlockable:
		knockback.CalculateKnockback(HitObject.global_position, attack.knockback * 0.8, attack.knockbackDecel)
		if attack.StunAttack:
			stun.Stun(attack.StunDuration * attack.StunPunishmentIncrease)
	
	# Handle the knockback if existent
	if knockback:
		knockback.CalculateKnockback(HitObject.global_position, attack.knockback, attack.knockbackDecel)
	
	# Handle Damaging
	if health_comp:
		health_comp.damage(attack.physical_damage, attack.damage)
	
	# TODO: Handle Elements
	
