class_name GdtGun
extends Node2D


enum GunStates{
	IDLE,
	SEMIAUTOTHING,
	FIRING,
	CUSTOMSTOP
}

signal proj_created(proj)
signal fired(gun)
signal postfired(gun)
signal stopped_firing(gun)
signal fullypoweredup(gun)
signal semi_auto_fired(gun)
signal consume_mana(apcost)
signal funnyrecoil(dir, inte)
signal charging(gun)
signal dir_fuckery(dir)
signal swapped_weapon(gun)
export var customfire = false
export(Array,Resource) var projectile_charge_info 


export(Resource) var _gun_data = (DarkPistolResourcePacker.new() as Resource)
export var is_enemy : bool = false

onready var muzzle :Position2D= $Position2D
onready var funnyposition = position
onready var muzzlepos = $Position2D.position
onready var spr = $SpriteSheet


var semi_auto_not_released = false
var current_state = GunStates.IDLE
var current_charge := 0.0
var dir : Vector2
var prev_data = DarkPistolResourcePacker.new()

var projectile_charge_index : int


func get_gun_data()->DarkPistolResourcePacker:return _gun_data

# should store the real direction somewhere
func deal_with_dir(pressed_dir: Vector2):
	dir = pressed_dir
	
	emit_signal("dir_fuckery",dir)



# instances the projectile and sets it's stats
func create_proj_instance(current_burst, current_pellet):
	if !_gun_data.bullet:return null
	
	var b:GdtBullet = _gun_data.bullet.instance()
	b.lifetime = _gun_data.data_res.bullet_lifetime
	b.muzzle = muzzle
	b.damage = _gun_data.data_res.damage
	b.speed = _gun_data.data_res.speed
	emit_signal("proj_created",b)
	return b

# gets the bullet dir rotation,
# override for funky rotation patterns for example dracula's hellfire shot from castlevania, 
# or some bullet hell type shit
func get_bullet_rotation(current_burst, current_pellet):
	var maxspread_as_rad = deg2rad(_gun_data.data_res.spread)
	return rand_range(-maxspread_as_rad,maxspread_as_rad)


# actually creates and instances the projectile
func create_projectile(current_burst, current_pellet):
	var b :GdtBullet= create_proj_instance(current_burst, current_pellet)
	if b:
		b.is_enemy = is_enemy
		b.global_position = muzzle.global_position
		
		
		b.dir = dir.rotated(get_bullet_rotation(current_burst,current_pellet))
		get_tree().current_scene.add_child(b)
		
	return b











func try_shooting():
	if fire_condition():
		fire()
		return true
	return false


func fire():
	if _gun_data.data_res.gun_fire_mode == CommonGunData.FiringModes.CHARGE:

		if current_charge == 0:
			prev_data= _gun_data
			projectile_charge_index = 0
			
			if _gun_data.data_res.fires_before_charging:
				fire_specific_charge_shot()
				
		
		if projectile_charge_info.size() > 0:
			projectile_charge_index = (int((current_charge / (_gun_data.data_res.max_charge) ) * (projectile_charge_info.size()) ) ) 
			
			
		if current_charge >= _gun_data.data_res.max_charge:
			emit_signal("fullypoweredup",self)
		current_charge = min(_gun_data.data_res.max_charge, current_charge + (.016*Engine.time_scale) )
		emit_signal("charging",self)
		
	actually_fire()


func fire_condition():
	return current_state == GunStates.IDLE and !semi_auto_not_released

func actually_fire():

		
	if _gun_data.data_res.gun_fire_mode == CommonGunData.FiringModes.SEMIAUTO:
		semi_auto_not_released = true

	current_state = GunStates.FIRING		
	if customfire:
		current_state = GunStates.CUSTOMSTOP
	
	
	for burst in _gun_data.data_res.burst_count:
		
		emit_signal("consume_mana")
		emit_signal("fired",self)
		emit_signal("funnyrecoil",dir,_gun_data.data_res.recoil)
		
		
		for pellet in _gun_data.data_res.pellet_count:
			create_projectile(burst,pellet)
			
		if not _gun_data.data_res.no_cooldown:
			yield(cooldown(),"completed")


	#idk why i forgor
	if not _gun_data.data_res.no_cooldown:
		yield(get_tree(),"idle_frame")
	postfire()


func cooldown()->GDScriptFunctionState:
	$"%Cooldown".wait_time = _gun_data.data_res.cooldown
	$"%Cooldown".start()
	# yield is kinda bad, but it works unlees i modify the script/an error happens
	# both that should NOT happen on any release
	yield($"%Cooldown","timeout")
	return null



func postfire():
	if !customfire:
		current_state = GunStates.IDLE

	if _gun_data.data_res.gun_fire_mode == CommonGunData.FiringModes.SEMIAUTO:
		emit_signal("semi_auto_fired",self)
	emit_signal("postfired",self)



func fire_specific_charge_shot():
	change_data(projectile_charge_info[projectile_charge_index])
	actually_fire()
	change_data(prev_data)
	
func stop_firing():
	semi_auto_not_released = false
	
	if _gun_data.data_res.gun_fire_mode == CommonGunData.FiringModes.CHARGE:
		if projectile_charge_info.size() > 0 and !current_charge >= _gun_data.data_res.max_charge:
			fire_specific_charge_shot()
			#current_charge = 0
			#return
	
	
	if current_charge >= _gun_data.data_res.max_charge and _gun_data.data_res.gun_fire_mode == CommonGunData.FiringModes.CHARGE:
		actually_fire()

	current_charge = 0
	emit_signal("stopped_firing",self)




func swapped():
	current_charge = 0
	semi_auto_not_released = false
	emit_signal("swapped_weapon",self)



func swapped_to():pass


func custom_state_reset():current_state = GunStates.IDLE


func change_data(data:DarkPistolResourcePacker):
	_gun_data = data
