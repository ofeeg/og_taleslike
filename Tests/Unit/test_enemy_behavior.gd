extends GutTest

class TestEnemyBehavior:
	extends GutTest
	var enemy
	var enemy_scene
	var enemy_obj
	var player
	func before_all():
		enemy_scene = load("res://Scenes/Enemy.tscn")
		enemy_obj = enemy_scene.instance()
		add_child(enemy_obj)
		enemy = $Enemy
		player = load("res://Scenes/Player.tscn").instance()
		gut.p("ran setup", 2)
		
	func after_all():
		enemy.free()
		
		player.free()
		gut.p("ran cleanup", 2)

	func test_movement():
		enemy.enemy_move(Vector2(200,200), 0.3)
		assert_ne(enemy.velocity, Vector2.ZERO)
		
	func test_detection_into_move():
		player.position = Vector2(200,200)
		enemy.alerted = true
		enemy.bodies.append(player)
		enemy.Do()
		assert_ne(enemy.velocity, Vector2.ZERO)
		
	func test_dormant_move():
		enemy.Do()
		assert_ne(enemy.velocity, Vector2.ZERO)
		
	func test_enemy_basic_attack():
		enemy.alerted = true
		watch_signals(enemy)
		enemy.bodies.append(player)
		player.position = Vector2(5,0)
		enemy.Do()
		yield(get_tree().create_timer(0.2), "timeout")
		
		assert_signal_emitted(enemy, "damaged")
