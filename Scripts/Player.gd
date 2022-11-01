extends KinematicBody2D

var velocity = Vector2()
var flipped = false
const GRAVITY = 500

var hp = 10
var def = 10
var atk = 10
var is_grounded = true
var is_hit = false

func _ready():
	$AnimationPlayer.play("Idle")
	pass # Replace with function body.

func _process(delta):
	if velocity.x > 0:
		flipped = false
		$Idle.visible = false
		$Walk.visible = true
		$Walk.set_flip_h(false)
		$Idle.set_flip_h(false)
		$AnimationPlayer.play("Walk")
	elif velocity.x < 0:
		flipped = true
		$Idle.visible = false
		$Walk.visible = true
		$Walk.set_flip_h(true)
		$Idle.set_flip_h(true)
		$AnimationPlayer.play("Walk")
	else:
		$Idle.visible = true
		$Walk.visible = false
		$AnimationPlayer.play("Idle")
func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity.y = GRAVITY*delta
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1000 * delta
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1000 * delta
	move_and_slide(velocity, Vector2.UP)
