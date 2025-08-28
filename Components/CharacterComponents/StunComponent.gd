extends Node
## Stores a value for entity for Stunning
class_name StunComponent

@export var IsStunned := false
@export var StunTimer : Timer

func Stun(duration):
	if IsStunned: return
	IsStunned = true
	StunTimer.start(duration)
	
