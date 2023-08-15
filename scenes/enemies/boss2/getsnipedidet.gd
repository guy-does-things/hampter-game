extends State

export var max_snipes = 4

var snipes = 0

func _enter_state(o,n):
	._enter_state(o,n)
	$SnipeTime.start()


func _exit_state(o,n):
	._exit_state(o,n)
	$SnipeTime.stop()
	$"%getsnipedidiet".visible = false
	snipes = 0
	

func _state_logic(dt):
	if ($SnipeTime.time_left) < .25:return
	$"%getsnipedidiet".visible = true
	$"%getsnipedidiet".global_position = $"%StatusThing".target.global_position
	
	
func _get_transition(dt):
	if snipes >= max_snipes:
		return $"%FuckitGoBack"


func _on_SnipeTime_timeout():
	$"%SnipeBox".global_position = $"%getsnipedidiet".global_position
	$"%SnipeBox".monitoring = true
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(.05,false),"timeout")
	$"%SnipeBox".monitoring = false
	
	yield(get_tree().create_timer(.25,false),"timeout")
	snipes += 1
	$SnipeTime.start()
