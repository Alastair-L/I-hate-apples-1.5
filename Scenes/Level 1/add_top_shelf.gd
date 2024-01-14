extends TileMap

var base_layer = 0
var source_id = 0
var overlay_layer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var atlas_id = Vector2i(0,4)
	TileMap
	var hi = tile_set.get_alternative_level_tile_proxy(atlas_id)
	print(hi)
	#add_layer(overlay_layer)
	#set_layer_z_index(overlay_layer, 2)

	#var cells_to_add_overlay_to = get_used_cells_by_id(base_layer, source_id, base_atlas_coords)
	#set_cell(overlay_layer, cell, source_id, overlay_atlas_coords, alternative_tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
