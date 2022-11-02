extends Node

var ATTACK_LIST = preload("res://Scripts/AttackList.gd").new()

#simple for now
func calculate_damage(target, src, dmg):
	return ((target.def >> 4) - (src.atk >> 2)) * dmg

func damage(target, true_dmg):
	target.hp -= abs(true_dmg)

func atk_interaction(target, src, attack):
	var raw_dmg = ATTACK_LIST.attacks.get(attack)
	damage(target, calculate_damage(target, src, raw_dmg))
	target.get_node("AnimationPlayer").play("Hit")
