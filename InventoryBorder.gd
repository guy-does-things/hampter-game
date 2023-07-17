extends Panel

var previous_ts = 0
var animating = false
export(NodePath) var cr_path;onready var cr :ColorRect= get_node(cr_path)

var current_menu :Control

func _physics_process(delta):
	if Input.is_action_just_pressed("show_inv") and !animating:
		if visible:
			
			Engine.time_scale = previous_ts
			
			yield(animate_cr(0,1),"completed")
			hide()
			yield(animate_cr(),"completed")
			
			get_tree().paused = false
			return
		
		previous_ts = Engine.time_scale
		Engine.time_scale = 1
		
		get_tree().paused = true
		yield(animate_cr(0,1,0,0),"completed")
		show()
		yield(animate_cr(),"completed")
		$VBoxContainer/Button.grab_focus()

	
	if Input.is_action_just_pressed("ui_cancel"):
		deselect()


func animate_cr(start_val=1,end_val=0,extra_yield_time=0,initial_yield=.5):
	animating = true
	if not cr:
		yield(get_tree(),"idle_frame")
		return

	cr.show()
	cr.modulate.a = start_val
	if initial_yield > .05:
		yield(get_tree().create_timer(.5),"timeout")
	
	yield(create_tween().tween_property(cr,"modulate:a",end_val,.2),"finished")
	cr.modulate.a = 1
	if extra_yield_time < .05:
		cr.hide()
		animating = false
		return
	yield(get_tree().create_timer(extra_yield_time),"timeout")
	cr.hide()
	animating = false
	
	
	
	return



func deselect(is_rs=false):
	if is_instance_valid(current_menu):current_menu.deselect()
	$VBoxContainer/Button.grab_focus()
	$VBoxContainer2.visible = !is_rs


func setup_player(plr,plrstatus):
	$"%ItemStuff".status = plrstatus

func select_menu(menu):
	deselect(true)
	menu.selected()
	current_menu = menu
	

func _on_Button_pressed():
	select_menu($"%ItemStuff")


func _on_Button4_pressed():
	select_menu($"%QuitMenu")


func _on_Button3_pressed():
	select_menu($"%Settings")


func _on_Button2_pressed():
	select_menu($"%Map")
	pass # Replace with function body.
