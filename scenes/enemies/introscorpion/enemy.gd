extends Entity

signal entered_hitstun()
signal exited_hitstun()



export var hitstun_starts_once_on_floor = false
export var hitstun_time = 1.2
var hitstun := Stun.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	hitstun.wait_time = hitstun_time
	$StateMachine.add_state(hitstun)
	hitstun.name = "hitstun"
	hitstun.starts_once_on_floor = hitstun_starts_once_on_floor
	hitstun.connect("entered",self,"emit_signal",["entered_hitstun"])
	hitstun.connect("exited",self,"emit_signal",["exited_hitstun"])
	$HurtComponent.connect("no_iframes",self,"hs_ended")
	hitstun.can_go_to_hurtstate = true
	
	
func hs_ended():
	hitstun.t.stop()
	hitstun.t_started = true


func _on_HurtComponent_hurted(dam,on_water):
	if $StateMachine.state and $StateMachine.state._can_transition_to_hurtstate():
		$StateMachine.set_state(hitstun)








func _on_HurtComponent_died(dam):
	queue_free()
