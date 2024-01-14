extends TileMap

var base_layer = 0
var source_id = 0
var overlay_layer = 1
var SOURCE_ID = 0
var BASE_TILE_ATLAS_ID = Vector2i(0,4)
var TOP_SHELF_TILE_ATLAS_ID = Vector2i(0,5)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get tile ids 
	var tile_atlas_source = tile_set.get_source(0)
	var base_tile_id = tile_atlas_source.get_tile_at_coords(BASE_TILE_ATLAS_ID)
	var top_shelf_tile_id = tile_atlas_source.get_tile_at_coords(TOP_SHELF_TILE_ATLAS_ID)
	
	add_layer(overlay_layer)
	set_layer_z_index(overlay_layer, 2)

	var cells_to_add_overlay_to = get_used_cells_by_id(base_layer, SOURCE_ID, BASE_TILE_ATLAS_ID)
	for cell in cells_to_add_overlay_to:
		set_cell(overlay_layer, cell, SOURCE_ID, TOP_SHELF_TILE_ATLAS_ID)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
