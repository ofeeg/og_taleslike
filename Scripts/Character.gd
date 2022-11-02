extends KinematicBody2D


var velocity = Vector2()
var flipped = false
const GRAVITY = 500

var hp = 10
var def = 10
var atk = 10
var is_grounded = true
var is_hit = false
var attacking = false


func flip_is_hit():
	is_hit = !is_hit
	print(is_hit)
