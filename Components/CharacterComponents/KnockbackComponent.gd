extends Node
class_name KnockbackComponent

@export var Entity: CharacterBody3D
signal Knockback(knockbackVelocity: Vector3, knockbackDecel)

func CalculateKnockback(HitLocation: Vector3, Force: float, Decel: float):
	var knockback_direction = (HitLocation - Entity.global_position).normalized()
	emit_signal("Knockback", knockback_direction * Force, Decel)
