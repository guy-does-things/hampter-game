extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RunTowardsPlayer_entered():
	play("run")


func _on_UpperCutCharge_entered():
	play("uppercutcharge")


func _on_Shoryuken_entered():
	play("uppercut")


func _on_StateMachine_changed_state(state, old_state):
	print(state,old_state)
	
	if state.name == "hitstun":
		play("knocked")
		get_parent().velocity.x = -170 * $"%Flippables".scale.x
		get_parent().velocity.y = -150
		
