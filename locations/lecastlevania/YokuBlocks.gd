extends TileMap

export(Array,PoolVector2Array) var yoku_things
var yoku_timer := Timer.new()
var yoku_step : int


func _ready():
	clear()
	add_child(yoku_timer)
	yoku_timer.wait_time = 1
	yoku_timer.one_shot = true
	yoku_timer.start()
	yoku_timer.connect("timeout",self,"yoku_block_timeout")
	


func yoku_animated_clear():
	for i in 4:
		for yb in get_used_cells():
			set_cellv(yb,13 if i != 3 else -1,false,false,false,Vector2(0,i))
		
		yield(get_tree().create_timer(.2,false),"timeout")
	
	
func yoku_block_timeout():
	if yoku_things.size() == 0:return
	yield(yoku_animated_clear(),"completed")
	yoku_timer.wait_time = 1
	
	
	for block in yoku_things[yoku_step]:
		if block.x != INF:
			set_cellv(block,13)
		else:
			yoku_timer.wait_time = block.y
	
	yoku_step += 1
	
	if yoku_step > yoku_things.size() - 1:
		yoku_step = 0
	
	
		
	yoku_timer.start()
