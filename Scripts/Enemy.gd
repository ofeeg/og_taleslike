extends "res://Scripts/Character.gd"


const  SPEED = 200
const ACCELERATION = 500
var _direction
var bodies = []
var alerted = false
var default_locs = [self.position]
var doing = false
signal damaged(bodies, source, attack)


enum {
	IDLE = 0b11111111,
	MOVE = 0b00000001,
	ATTACK = 0b10000000,
}
onready var state = IDLE

func Do():
	if doing: return
	if alerted:
		if clamp(bodies[0].position.x - self.position.x, -10, 10) == bodies[0].position.x - self.position.x:
			flip_doing()
			$AnimationPlayer.play("Attack")
			return
		flip_doing()
		enemy_move(bodies[0].position, 0.03)
	else:
		flip_doing()
		enemy_move(Vector2(default_locs[0].x-20, default_locs[0].y), 0.03)


func enemy_move(target, delta):
	_direction = global_position.direction_to(target)
	_direction.x = clamp(_direction.x, 10, 100)
	velocity = velocity.move_toward(_direction * SPEED, ACCELERATION * delta)


func hit():
	var targets  = $Attack/Area2D.get_overlapping_bodies()
	emit_signal('damaged', targets, self, "Basic")


func _process(delta):
	Do()
	match state:
		IDLE:
			$AnimationPlayer.play("Idle")
			yield(get_tree().create_timer(1), "timeout")
			return
		ATTACK:
			pass
	if velocity.x > 0:
		$Idle.visible = false
		$Move.visible = true
		if flipped:
			scale.x *= -1
			flipped  = false
		$AnimationPlayer.play("Move")
	elif velocity.x < 0:
		$Idle.visible = false
		$Move.visible = true
		if !flipped:
			flipped = true
			scale.x *= -1
		$AnimationPlayer.play("Move")
	else:
		if !attacking:
			$Attack.visible = false
			$Idle.visible = true
			$Move.visible = false
			$AnimationPlayer.play("Idle")


func flip_doing():
	doing != doing
	
