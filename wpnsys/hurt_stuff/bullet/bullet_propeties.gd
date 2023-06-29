class_name BulletPropeties
extends Resource

export var deletes_on_wall := true
export var deletes_on_enemy_hit := true
export var deletes_on_ally_hit := false
export var deletes_on_timeout := true

# ignores the last safe margin for a collision
# do not use with high speeds
# propety was added mostly (exclusively atm) for the 
# sniper + dark card projectile
export var ignores_anti_tunneling_measures := false

