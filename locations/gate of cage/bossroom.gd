extends NewestRoom

var bs :BossSpawner = null



func _ready():
	Signals.connect("boss_death_anim_state",self,"_on_EnemySpawner_boss_ded")
	
	for i in $RoomObjectManager.get_children():
		if i is BossSpawner:
			var err = i.connect("start_enc",self,"_on_EnemySpawner_start_enc")
			bs = i
			break

func _on_EnemySpawner_start_enc():

	for i in get_children():
		if i is Door:
			i.force_close()


func _on_EnemySpawner_boss_ded(start):
	if start:return
	bs.setup_interaction_status(-1,true,false)
	
	for i in get_children():
		if i is Door:
			i.force_open()
			
	return true
