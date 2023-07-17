tool
extends Sprite

var region_size_y = 0 setget set_region_size_y; func set_region_size_y(iry):
	region_size_y = iry
	region_rect.size.y = floor(iry)
