extends GutTest

class TestWorld:
	extends GutTest
	var world
	var level_scene
	var level_instance
	var player
	var enemies
	func before_all():
		level_scene = load("res://Scenes/TestLevel.tscn")
		level_instance = level_scene.instance()
		add_child(level_instance)
		world = $Level
		player = $Level/Player
		enemies = get_tree().get_nodes_in_group("Enemy")
		gut.p("ran setup", 2)
	func after_all():
		world.free()
		#player.free()
		#enemies.map(free())
		gut.p("ran clean up", 2)
	
	func test_calculate_damage():
		assert_ne(world.calculate_damage(player, enemies[0], 10), 0)
		
	func test_damage():
		world.damage(player, 8)
		assert_eq(player.hp, 2)
	
	func test_atk_interaction():
		world.atk_interaction(player, enemies[0], "Basic")
		yield(yield_for(0.3), YIELD)
		assert_true(player.is_hit)
