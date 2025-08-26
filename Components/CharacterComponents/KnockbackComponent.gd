extends Node3D
class_name KnockbackComponent

@export var Entity: CharacterBody3D
signal Knockback(knockbackVelocity: Vector3)

func CalculateKnockback(HitLocation: Vector3, Force: float):
	var knockback_direction = (HitLocation - Entity.global_position).normalized()
	emit_signal("knockback", knockback_direction * Force)
