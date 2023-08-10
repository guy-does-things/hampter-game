extends Node2D

var boss : Entity

class DeathPoly extends Polygon2D:
	var ipr = 0
	var spr = 0
	enum AnimationStates{
		NONE,
		STARTED,
		FINISHED
	}
	
	var a_state = AnimationStates.NONE
	var boss_died = false
	
	func _init(ipr=PI*2,spr=PI/8):
		self.ipr = ipr
		self.spr = spr
		
	func poly_exp_line():
		if a_state != AnimationStates.NONE:return
		
		a_state = AnimationStates.STARTED
		var points = [Vector2.ZERO]
		
		#aka 360 degrees
		var initial_point_rotation = ipr
		var second_point_rotation = spr
		var initial_point = Vector2.RIGHT.rotated(rand_range(-initial_point_rotation,initial_point_rotation))*rand_range(75,200)
		points.append(initial_point)
		points.append(initial_point.rotated(rand_range(-second_point_rotation,second_point_rotation)))
		polygon = points
		

		yield(
			create_tween().tween_property(self,"scale",Vector2.ZERO,.1).set_trans(Tween.TRANS_BOUNCE),
			"finished"
		)
		#yield(get_tree().create_timer(.1,false),"timeout")

		if boss_died:queue_free()

		a_state = AnimationStates.FINISHED
		
		
	func _physics_process(delta):
		if a_state == AnimationStates.FINISHED:
			scale = Vector2.ONE
			a_state = AnimationStates.NONE
		
		if a_state == AnimationStates.NONE:
			color = Color.yellow
			color.a = .6
			poly_exp_line()




	

func _ready():
	Signals.emit_signal("boss_death_anim_state",true)
	for i in 4:
		add_child(DeathPoly.new())
	
	
	for i in 64:
		Globals.hit_fuckery(global_position)
			
		
		for x in 2:
			Globals.died(global_position+ Vector2(rand_range(-32,32),rand_range(-32,32) ) )
		yield(get_tree().create_timer(.1,false),"timeout")
	


	yield(get_tree().create_timer(.1,false),"timeout")
	Globals.hit_fuckery(global_position).volume_db = 4
	var finaldeathparts :Node2D = Globals.died(global_position  )
	finaldeathparts.scale *= 3
	
	
	# will crash because the current scene is self, works fine elseware
	for poly in get_children():
		poly.boss_died = true
	
	if is_instance_valid(boss):
		boss.queue_free()
	Signals.emit_signal("boss_death_anim_state",false)
	queue_free()
