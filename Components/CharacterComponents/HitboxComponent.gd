extends Area3D
class_name HitboxComponent

@export var Atk: Attack
@export var Decay := 1.0 ## Decay Time till Queue Free

func initialize():
	var decayTimer = Timer.new()
	decayTimer.name = "Decay"
	add_child(decayTimer)
	decayTimer.connect("timeout", decay)
	decayTimer.start(Decay)
	

func decay():
	queue_free()

func onHit(area: Area3D):
	if area is HurtboxComponent:
		area.handle_hit(Atk)
	
