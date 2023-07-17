extends State


func _get_transition(delta):
	var rindex =randi() % 3
	
	
	return [
		$"%RunTowardsPlayer",
		$"%Shoot",
		$"%JumpTowardsPlayer"
	][rindex]
