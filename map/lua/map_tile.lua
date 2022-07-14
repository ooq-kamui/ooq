log.scrpt("map_tile.lua")

-- tile

function Map.tile__new(_s) -- use not
	-- nothing
end

function Map.tile__clr(_s) -- use not

	local tilemap, layer = "ground", "ground"

	local tilemap_url = _s:tilemap_url(tilemap)

	local t_tile = 0

	local x_min, x_max, y_min, y_max = map.rng_tilepos_xy(_s._id, tilemap)
	for y = y_min, y_max do
		for x = x_min, x_max do
			tile.__(tilemap_url, layer, x, y, t_tile)
		end
	end
end

function Map.tile__save_data(_s, data)
	
	_s:tile_layer__("ground", data["ground"])
	_s:tile_layer__("wall"  , data["wall"]  )
end

function Map.save_data_6_tile(_s)
	
	local r_tile = {}
	r_tile["ground"] = _s:tile("ground")
	r_tile["wall"]   = _s:tile("wall")
	return r_tile
end

function Map.tile(_s, p_tilemap)

	p_tilemap = p_tilemap or Map.tilemap_dflt

	local tilemap_url = _s:tilemap_url(p_tilemap)
	local t_layer = p_tilemap

	local tiles, x, y, t_tile
	local rng_tilepos = _s:rng_tilepos(p_tilemap)

	tiles = {} -- tiles[y][x]
	for y = rng_tilepos.min.y, rng_tilepos.max.y do
		tiles[int._2_str(y)] = {}
		for x = rng_tilepos.min.x, rng_tilepos.max.x do
			
			t_tile = tile._(tilemap_url, t_layer, x, y)
			tiles[int._2_str(y)][int._2_str(x)] = t_tile
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

-- tile

function Map.tile__(_s, p_pos, p_tile)

	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)

	map.tile__6_tilepos_xy(x, y, p_tile, _s._id, "ground")

	_s:tile_tile__6_tilepos_xy(x, y, p_tile)
end

function Map.tile_xy__init_6_tilepos_xy(_s, x, y)

	if not _s._tile[y]    then _s._tile[y]    = {} end
	if not _s._tile[y][x] then
		_s._tile[y][x]        = {}
		_s._tile[y][x]["obj"] = {}
	end
end

function Map.tile_xy__init_6_pos(_s, p_pos)
	
	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)
	_s:tile_xy__init_6_tilepos_xy(x, y)
end

function Map.tile_tile__6_tilepos_xy(_s, x, y, p_tile)

	_s:tile_xy__init_6_tilepos_xy(x, y)

	_s._tile[y][x]["tile"] = p_tile
end

function Map.tile_obj__del_add(_s, p_id, p_cls, p_pos_c, p_pos_n)

	-- _s:tile_xy__init_6_pos(p_pos_c)
	_s:tile_xy__init_6_pos(p_pos_n)
	
	_s:tile_obj__del(p_id, p_cls, p_pos_c)
	_s:tile_obj__add(p_id, p_cls, p_pos_n)
end

function Map.tile_obj__del(_s, p_id, p_cls, p_pos)

	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)
	
	_s:tile_xy__init_6_tilepos_xy(x, y)
	
	if not _s._tile[y][x]["obj"][p_cls] then
		_s._tile[y][x]["obj"][p_cls] = {}
	end
	
	_s._tile[y][x]["obj"][p_cls][p_id] = nil
end

function Map.tile_obj__add(_s, p_id, p_cls, p_pos)
	
	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)

	if not _s._tile[y][x]["obj"][p_cls] then
		_s._tile[y][x]["obj"][p_cls] = {}
	end

	_s._tile[y][x]["obj"][p_cls][p_id] = _.t
end

-- tile static

function Map.tile__crct(p_tilepos, p_id, p_tilemap, layer)
	-- log._("map.tile__crct", p_tilepos, p_tilemap, layer)

	local center_tile = map.tile_6_tilepos_xy(p_tilepos.x, p_tilepos.y, p_id, p_tilemap, layer)
	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(center_tile)
	-- log._("tile__crct ", center_tile, is_tile_bndl, base_tile)

	if not is_tile_bndl then return end

	-- 
	-- tile bndl
	-- 
	local tile_bndl_arund_val = Map.tile_bndl_arund_val(p_tilepos)
	local crct_tile = Tile_bndl.crct_tile(base_tile, tile_bndl_arund_val)

	local t_url = url._(p_id, p_tilemap)
	-- tilemap.set_tile(t_url, layer, p_tilepos.x, p_tilepos.y, crct_tile)
	tile.__(t_url, layer, p_tilepos.x, p_tilepos.y, crct_tile)
end

function Map.arund_tile_bndl_ar(p_tilepos, p_tile)

	p_tile = p_tile or map.tile_6_tilepos_xy(p_tilepos.x, p_tilepos.y, Game.map_id(), "ground")

	local base_tile = Tile_bndl.base_tile(p_tile)

	if not base_tile then return end

	-- arund_tile
	local tilepos_arund = Map.tilepos_arund(p_tilepos)
	-- log.pp("Map.arund_tile_bndl_ar", tilepos_arund)

	local tile_bndl_arund_ar = {}
	local t_tile, t_tilepos, is_base_tile_bndl

	for idx, t_tilepos in pairs(tilepos_arund) do

		t_tile = map.tile_6_tilepos_xy(t_tilepos.x, t_tilepos.y, Game.map_id(), "ground")
		-- log._("map.arund_tile_bndl_ar", idx, t_tile, t_tilepos)

		if t_tile then
			is_base_tile_bndl = Tile_bndl.is_base_tile_bndl(t_tile, base_tile)
		else
			is_base_tile_bndl = _.f
		end
		-- log._("is_base_tile_bndl", is_base_tile_bndl)

		ar.add(tile_bndl_arund_ar, is_base_tile_bndl)
		-- log.pp("tile_bndl_arund_ar", tile_bndl_arund_ar)
	end
	-- log.pp("Map.arund_tile_bndl_ar", tile_bndl_arund_ar)
	return tile_bndl_arund_ar
end

function Map.tile_bndl_arund_val(p_tilepos)
	-- log._("map.tile_bndl_arund_val", p_tilepos)

	local center_tile = map.tile_6_tilepos_xy(p_tilepos.x, p_tilepos.y, Game.map_id(), "ground")
	local base_tile = Tile_bndl.base_tile(center_tile)
	if not base_tile then return end

	local tile_bndl_arund_ar  = Map.arund_tile_bndl_ar(p_tilepos)
	local tile_bndl_arund_val = Tile_bndl.arund_ar_2_arund_val(tile_bndl_arund_ar)
	-- log._("tile_bndl_arund_val", tile_bndl_arund_val)

	return tile_bndl_arund_val
end

function Map.tilepos_arund(p_tilepos) -- todo cache

	local tilepos_arund = {
		n.vec(p_tilepos.x - 1, p_tilepos.y + 1, nil, "Map.tilepos_arund"),
		n.vec(p_tilepos.x + 0, p_tilepos.y + 1, nil, "Map.tilepos_arund"),
		n.vec(p_tilepos.x + 1, p_tilepos.y + 1, nil, "Map.tilepos_arund"),

		n.vec(p_tilepos.x - 1, p_tilepos.y    , nil, "Map.tilepos_arund"),
		n.vec(p_tilepos.x + 1, p_tilepos.y    , nil, "Map.tilepos_arund"),

		n.vec(p_tilepos.x - 1, p_tilepos.y - 1, nil, "Map.tilepos_arund"),
		n.vec(p_tilepos.x + 0, p_tilepos.y - 1, nil, "Map.tilepos_arund"),
		n.vec(p_tilepos.x + 1, p_tilepos.y - 1, nil, "Map.tilepos_arund"),
	}
	return tilepos_arund
end

