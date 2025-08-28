extends Node
## Node Attack for holding Attack Data
class_name Attack

@export var physical_damage := 0 ## Damage Bypassing Sheild
@export var damage := 0 ## Damage Absorbed by Sheild
@export var knockback := 30.0
@export var knockbackDecel := 10.0
@export var elements := []
@export var isBlockable := false
@export var StunAttack := false
@export var StunDuration := 1.0
@export var StunPunishmentIncrease := 1.2

@export var AttackerName := ""

#--- Special Damage Added Below
