extends Node

#simple for now
func calculate_damage(target, src, dmg):
	((target.def >> 4) - (src.atk >> 2)) * dmg

func damage(target, true_dmg):
	target.hp -= abs(true_dmg)
