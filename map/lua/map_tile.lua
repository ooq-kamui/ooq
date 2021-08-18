log.scrpt("map_tile.lua")

-- tile

function Map.tile__new(_s)
	-- nothing
end

function Map.tile__clr(_s)

	local tilemap, layer = "ground", "ground"

	local tilemap_url = _s:tilemap_url(tilemap)

	local x_min, x_max, y_min, y_max = map.rng_tilepos_xy(_s._id, tilemap)
	for y = y_min, y_max do
		for x = x_min, x_max do
			tilemap.set_tile(tilemap_url, layer, x, y, 0)
		end
	end
end

function Map.tile__save_data(_s, data)
	
	_s:tile_layer__("ground", data["ground"])
	_s:tile_layer__("wall"  , data["wall"]  )
end

function Map.save_data_6_tile(_s)
	
	local tile = {}
	tile["ground"] = _s:tile("ground")
	tile["wall"]   = _s:tile("wall")
	return tile
end

function Map.tile(_s, p_tilemap)

	p_tilemap = p_tilemap or Map.tilemap_dflt

	local tilemap_url = _s:tilemap_url(p_tilemap)
	-- log._("tilemap_url", tilemap_url)
	
	local t_layer = p_tilemap

	local tiles, x, y, tile
	local rng_tilepos = _s:rng_tilepos(p_tilemap)

	tiles = {} -- tiles[y][x]
	for y = rng_tilepos.min.y, rng_tilepos.max.y do
		tiles[int._2_str(y)] = {}
		for x = rng_tilepos.min.x, rng_tilepos.max.x do
			
			tile = tilemap.get_tile(tilemap_url, t_layer, x, y)
			tiles[int._2_str(y)][int._2_str(x)] = tile
		end
	end
	
	return tiles
end

function Map.tile_layer__(_s, p_tilemap, tiles) -- tiles[y][x]

	if u.is_emp(tiles) then log.pp("map.tile__", tiles) return end
	-- log.pp("map.tile__", tiles)
	
	p_tilemap = p_tilemap or Map.tilemap_dflt
	
	local t_layer     = p_tilemap
	local tilemap_url = _s:tilemap_url(p_tilemap)

	local rng_tilepos = _s:rng_tilepos(p_tilemap)
	
	local x, y, t_tile
	
	for y = rng_tilepos.min.y, rng_tilepos.max.y do
		for x = rng_tilepos.min.x, rng_tilepos.max.x do
			t_tile = tiles[int._2_str(y)][int._2_str(x)]
			tile.__(tilemap_url, t_layer, x, y, t_tile)
		end
	end
end

function Map.rng_tilepos(_s, p_tilemap)

	if _s._rng_tilepos then return _s._rng_tilepos end

	p_tilemap = p_tilemap or Map.tilemap_dflt

	-- log._("Map.rng_tilepos", p_tilemap)
	_s._rng_tilepos = map.rng_tilepos(_s._id, p_tilemap)
	return _s._rng_tilepos
end

