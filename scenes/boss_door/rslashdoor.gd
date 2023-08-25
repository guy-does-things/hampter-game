extends Door


func _on_Trigger_body_exited(body):
	if (body.get_node("StatusThing") as StatusThing).raw_hasitem(Globals.Items.RISINGSLASH):
		._on_Trigger_body_entered(body)
