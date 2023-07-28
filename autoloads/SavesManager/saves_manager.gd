extends Node

const EXTENSION = ".sex"
const SAVE_DIR = "user://saves"
const SETTINGS_PATH = "user://settings.json"
var saves := []


var current_save : NewSaveData = NewSaveData.new()
var settings : Settings = Settings.new()


# errors continuing from the Errors enum
enum LoadErrors{
	CHECKSUM_FAILURE=49,
	NONEXISTANT_CHECKSUMS=50,
	NONEXISTANT_SAVE=51
}



# testing saving
func _ready():
	create_save_dir()
	var f = File.new()
	var st = Time.get_unix_time_from_system()
	current_save.save_path = SAVE_DIR+"/"+"name.sex"
	var tried_load_save = load_save(SAVE_DIR+"/"+"name.sex")
	if tried_load_save is NewSaveData:
		current_save = tried_load_save
		
	
	var lt = Time.get_unix_time_from_system() - st
	st = Time.get_unix_time_from_system()
	#save(current_save)
	var sat = Time.get_unix_time_from_system() - st
	
	print_debug(str("load time:",lt, "  save time:", sat))
	


func create_save_dir():
	var dir :Directory= Directory.new()
	
	if not dir.dir_exists(SAVE_DIR):
		dir.make_dir(SAVE_DIR)
	
	


func save(to_save:NewSaveData):
	var errors := {
		"codes":[],
		"messages":[]
	}
	
	var f :File= File.new()
	var d := Directory.new()
	# create backup save
	if f.open(to_save.save_path,File.READ)==OK:
		d.open(SAVE_DIR)
		var e = d.rename(to_save.save_path,to_save.save_path.replace(".sex",".bak"))
		f.close()
		
		
	# actually save the game
	var er = f.open(to_save.save_path,File.WRITE)
	if er==OK:
		f.store_buffer(to_save.as_buffer())
	else:
		errors.codes.append(er)
		errors.messages.append("NOT SAVED")
	f.close()
	
	# create 2 checksum files
	for i in 2:
		d.rename(
			current_save.save_path.replace(".sex",".gex"+str(i)),
			current_save.save_path.replace(".sex",".gex"+str(i)).replace(".gex"+str(i),".gexb"+str(i))
		)
	
		er = f.open(current_save.save_path.replace(".sex",".gex"+str(i)),File.WRITE)
		if er == OK:
			f.store_buffer(current_save.md5_hash())
		else:
			errors.codes.append(er)
			errors.messages.append("CHECKSUM SAVING ERROR")
		f.close()
		
	return errors


func load_checksum_file(path:String,errors:=[]):
	var f := File.new()
	var r :int = f.open(path,File.READ)
	var checksum = null
	if r==OK:
		checksum = f.get_buffer(f.get_len())
	else:
		errors.append(r)
	f.close()
	
	return checksum
	



func load_save(path:String):
	# get hashes
	var errors := []
	var md5_1 = null#= 
	var md5_2 = null#= f.get_buffer(f.get_len())
	var f = File.new()
	
	var r : int
	
	
	md5_1 = load_checksum_file(path.replace(".sex",".gex0"),errors)
	md5_2 = load_checksum_file(path.replace(".sex",".gex1"),errors)
	
	
	
	r = f.open(path,File.READ)
	# fallback to ".bak" file
	if r != OK:
		var prev_error = r
		errors.append(prev_error)
		f.close()
		r = f.open(path.replace(".sex",".bak"),File.READ)
		
		if r != OK:
			errors.append(r)
			return errors
		
		
	var save_buffer = f.get_buffer(f.get_len())
	var save_md5 = str(save_buffer).md5_buffer()

	if not (save_md5 == md5_1 or save_md5 == md5_2):
		f.close()
		r = f.open(path.replace(".sex",".bak"),File.READ)
		
		if r != OK:
			f.close()
			errors.append(r)
			return errors
		
		save_buffer = f.get_buffer(f.get_len())
		save_md5 = str(save_buffer).md5_buffer()
		
		md5_1 = load_checksum_file(path.replace(".sex",".gexb0"))
		md5_2 = load_checksum_file(path.replace(".sex",".gexb1"))
		f.close()
		
		
		
		
		if not (save_md5 == md5_1 or save_md5 == md5_2):
			errors.append(LoadErrors.CHECKSUM_FAILURE)
			return errors
		
		
	
		
	var s = NewSaveData.new()
	s.save_path = path
	s.from_dict(bytes2var(save_buffer))
	f.close()
	return s







	
	



	
	
	
	
	
	
	
	
	
	

	
	
	
