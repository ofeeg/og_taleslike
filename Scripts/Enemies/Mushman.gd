extends "res://Scripts/Enemy.gd"

onready var target = self.position
var moving = false
var dormant = true
#var combative = true

func _physics_process(delta):
	if dormant:
		if moving:
			enemy_move(Vector2(target.x-20, target.y), delta)
			moving = false
	move_and_slide(velocity)

func hit():
	var bodies  = $Attack/Area2D.get_overlapping_bodies()

func _on_Dormant_timeout():
	if !dormant:
		return
	moving = true
	#dormant = true
	pass # Replace with function body.


func _on_Vision_body_entered(body):
	dormant = false
	$Action.start()
	pass # Replace with function body.



func _on_Action_timeout():
	velocity = Vector2.ZERO
	$Idle.visible = false
	$Move.visible = false
	$Attack.visible = true
	attacking = true
	$AnimationPlayer.play("Attack")
	print(attacking)
	print(moving)
	print(dormant)
	attacking = false


func flip_doing():
	doing != doing
	
