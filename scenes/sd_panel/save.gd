extends Button

var save :NewSaveData

func initialize(save:NewSaveData):
	self.save = save
	if save:
		$Control.show()
		$Control/HampterName.text = save.name
		$Control/Time.text = Igt.FormatTime(save.igt)
		$TextureRect.visible = save.beat
		$Control/Stats/HP.text = str(6+save.hp_stacks,"HP")
	else:
		$Label.show()
	


func _on_Button_pressed():
	get_tree().change_scene_to(
		preload("res://locations/roompositions.tscn")
	)
