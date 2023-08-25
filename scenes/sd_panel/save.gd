class_name SaveBtn
extends Button

signal save_sel(save)

var save :NewSaveData
var save_path : String

func initialize(save:NewSaveData,path:String):
	self.save = save
	save_path =path
	
	
	if save.played:
		$Control.show()
		$Control/HampterName.text = save.name
		$Control/Time.text = Igt.FormatTime(save.igt)
		$TextureRect.visible = save.beat
		$TextureRect2.visible = save.bossrush
		$Control/Stats/HP.text = str(6+save.hp_stacks,"HP")
		$Label.hide()
	else:
		$Control.hide()
		$Label.show()
	
	print_debug($Label.visible,save.played)


func _on_Button_pressed():
	emit_signal("save_sel",self)
#	get_tree().change_scene_to(
#		preload("res://locations/roompositions.tscn")
#	)
