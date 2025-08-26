extends Node3D
class_name HealthComponent

@export var MAX_HEALTH := 100.0
var health := 0.0

@export var MAX_SHEILD := 50.0
var sheild := 0.0

## Multiplied to health after damage calculation.
## Can be used to fully negate damage if set to zero.
## The Closer to zero the more damage is negated
@export var HealthControl := 1.0

signal Death

func Damage(PureDamage: float, AbsorbedDamage: float):
	health -= PureDamage * HealthControl
	if sheild > 0.0:
		sheild -= AbsorbedDamage * HealthControl
	else:
		health -= AbsorbedDamage * HealthControl
	
	if health <= 0:
		emit_signal("Death")
