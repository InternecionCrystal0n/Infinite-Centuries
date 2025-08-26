extends Area3D

@export var attack: Attack

func _AreaEnter(area):
	if area.name.begins_with("Hitbox"):
		area.damage(attack, self)
