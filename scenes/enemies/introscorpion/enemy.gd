extends Entity

signal entered_hitstun()



export var hitstun_time = 1.2
var hitstun := Stun.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	hitstun.wait_time = hitstun_time
	$StateMachine.add_state(hitstun)
	hitstun.name = "hitstun"
	hitstun.connect("entered",self,"emit_signal",["entered_hitstun"])
	hitstun.can_go_to_hurtstate = true

func _on_HurtComponent_hurted(dam,on_water):
	if $StateMachine.state and $StateMachine.state._can_transition_to_hurtstate():
		$StateMachine.set_state(hitstun)







func _on_HurtComponent_died(dam):
	queue_free()
