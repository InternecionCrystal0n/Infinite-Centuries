extends Area3D
class_name HurtboxComponent

@export var health_comp : HealthComponent
@export var entity : CharacterBody3D
@export var knockback : KnockbackComponent

func handle_hit(attack: Attack, HitObject: Area3D):
	if knockback:
		knockback.CalculateKnockback(HitObject.global_position, attack.knockback)
	if entity.Blocking and attack.isBlockable:
		var origin = entity.global_transform.origin
		var dir = entity.global_transform.basis.z
		# TODO: BLOCK ANGLE SHOULD BE GIVEN BY THE WEAPON COMPONENT
		
	if health_comp:
		health_comp.damage(attack.physical_damage, attack.damage)
	
	
