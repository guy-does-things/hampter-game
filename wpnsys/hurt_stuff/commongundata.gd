tool
class_name CommonGunData
extends Resource

enum FiringModes{
	SEMIAUTO,
	FULLAUTO,
	CHARGE,
	LAZER,
}

export var gun_name : String
export(String,MULTILINE) var gun_desc : String

export(FiringModes) var gun_fire_mode
export var fires_before_charging = false
# 2048 is a random high number with no real technical relevance
export(float,1,2048) var pellet_count := 1 
export(float,1,2048) var burst_count := 1 
export(float,.05,2048) var cooldown := 1.0
export var max_charge := 0.0
export var spread := 0.0
export var recoil := .0
export var rotation_recoil := .0
export var damage = 1
export var speed = 400
export var bullet_lifetime := 2.0

export var no_cooldown := false


