extends Area3D
class_name HitboxComponent

@export var Atk: Attack
@export var Decay := 1.0 ## Decay Time till Queue Free

func launch():
	pass

func onHit(area: Area3D):
	if area is HurtboxComponent:
		area.handle_hit(Atk)
	
