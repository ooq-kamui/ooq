log.scrpt("map_tile.lua")

-- tile

function Map.tile__(_s, p_pos, p_tile, p_tilemap) -- alias
	
	_s:tile__6_pos(p_pos, p_tile, p_tilemap)
	
	---[[ log
	-- local x, y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)
	-- _s:log_tile_xy(x, y)
	--]]
end

function Map.tile__6_pos(_s, p_pos, p_tile, p_tilemap)

	p_tilemap = p_tilemap or "ground"

	local x, y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)

	_s:tile__6_tile_xy(x, y, p_tile, p_tilemap)
end

function Map.tile__6_tile_xy(_s, x, y, p_tile, p_tilemap)
	
	p_tilemap = p_tilemap or "ground"
	layer     = p_tilemap
	
	local tile_prv = map.tile_6_tile_xy(x, y, _s._id, p_tilemap, layer)
	
	map.tile__6_tile_xy(x, y, p_tile, _s._id, p_tilemap, layer)
	
	if not (p_tilemap == "ground" and layer == "ground") then return end
	
	-- tile crct
	
	local tile_bndl = (p_tile == Tile.mstr.emp) and tile_prv or p_tile
	
	_s:tile_arund__crct_6_tile_xy(x, y, tile_bndl, p_tilemap)

	if p_tilemap ~= "ground" then return end
	
	-- tile_xy
	
	_s:tile_xy_tile__6_tile_xy(x, y, p_tile)
end

function Map.tile_6_tile_xy(_s, x, y, p_tilemap)
	
	local t_layer = p_tilemap
	
	local r_tile = map.tile_6_tile_xy(x, y, _s._id, p_tilemap, t_layer)
	return  r_tile
end
	
function Map.tile__clr(_s, p_tilemap) -- use not

	p_tilemap = p_tilemap or "ground"

	local t_tile = Tile.mstr.emp

	local x_min, x_max, y_min, y_max = _s:rng_tile_xy(p_tilemap)
	for y = y_min, y_max do
		for x = x_min, x_max do
			map.tile__6_tile_xy(x, y, t_tile, _s._id, p_tilemap)
		end
	end
end

function Map.tile_arund__crct_6_tile_xy(_s, x, y, p_tile, p_tilemap, layer)
	-- log._("tile_arund__crct", p_tile)
	
	layer = layer or p_tilemap
	
	local tile_bndl = p_tile
	local t_tilepos = n.vec(x, y)
	
	-- cntr
	
	_s:tile__crct(t_tilepos, p_tilemap, layer)

	-- arund
	
	local arund_flg = _s:tile_arund_bndl_flg(t_tilepos, tile_bndl)
	
	if not arund_flg then return end
	
	local arund_tilepos = Map.tilepos_arund(t_tilepos)

	if arund_flg[2] then _s:tile__crct(arund_tilepos[2], p_tilemap, layer) end
	if arund_flg[4] then _s:tile__crct(arund_tilepos[4], p_tilemap, layer) end
	if arund_flg[5] then _s:tile__crct(arund_tilepos[5], p_tilemap, layer) end
	if arund_flg[7] then _s:tile__crct(arund_tilepos[7], p_tilemap, layer) end
end

-- tile_xy ( ground )

function Map.tile_xy__init(_s)
	
	local tilemap = "ground"
	
	_s._tile = {}
	
	local x_min, x_max, y_min, y_max = _s:rng_tile_xy(tilemap)
	for y = y_min, y_max do
		
		ar.chld_ar__init_if_nil(_s._tile, y)
		
		for x = x_min, x_max do
			
			ar.chld_ar__init_if_nil(_s._tile[y]   , x    )
			ar.chld_ar__init_if_nil(_s._tile[y][x], "obj")
			_s._tile[y][x]["tile"] = Tile.mstr.emp
		end
	end
end

function Map.tile_xy__init_6_tile_xy(_s, x, y)

	ar.chld_ar__init_if_nil(_s._tile      , y    )
	ar.chld_ar__init_if_nil(_s._tile[y]   , x    )
	ar.chld_ar__init_if_nil(_s._tile[y][x], "obj")
end

function Map.tile_xy__init_6_pos(_s, p_pos)
	
	local x, y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)
	_s:tile_xy__init_6_tile_xy(x, y)
end

-- tile_xy tile

function Map.tile_xy_tile__6_tile_xy(_s, x, y, p_tile)

	-- _s:tile_xy__init_6_tile_xy(x, y)

	_s._tile[y][x]["tile"] = p_tile
end

function Map.tile_xy_tile__crnt(_s)
	
	local t_tilemap = "ground"
	local t_tile
	local x_min, x_max, y_min, y_max = _s:rng_tile_xy(t_tilemap)
	for   y = y_min, y_max do
		for x = x_min, x_max do
			
			t_tile = _s:tile_6_tile_xy(x, y, t_tilemap)
			_s:tile_xy_tile__6_tile_xy(x, y, t_tile)
		end
	end
end

-- tile_xy obj

function Map.tile_xy_obj__del_add(_s, p_id, p_cls, p_pos_c, p_pos_n)
	
	_s:tile_xy_obj__del(p_id, p_cls, p_pos_c)
	_s:tile_xy_obj__add(p_id, p_cls, p_pos_n)
end

function Map.tile_xy_obj__del(_s, p_id, p_cls, p_pos)

	local x, y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)
	
	_s:tile_xy__init_6_tile_xy(x, y)
	
	ar.chld_ar__init_if_nil(_s._tile[y][x]["obj"], p_cls)
	
	_s._tile[y][x]["obj"][p_cls][p_id] = nil
	
	if ar.is_emp(_s._tile[y][x]["obj"][p_cls]) then
		_s._tile[y][x]["obj"][p_cls] = nil
	end
end

function Map.tile_xy_obj__add(_s, p_id, p_cls, p_pos)
	
	local x, y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)

	if not _s._tile[y][x]["obj"][p_cls] then
		_s._tile[y][x]["obj"][p_cls] = {}
	end

	_s._tile[y][x]["obj"][p_cls][p_id] = _.t
end

-- tile save_data

function Map.tiles__save_data(_s, data)
	
	_s:tile_layer__save_data("ground", data["ground"])
	_s:tile_layer__save_data("wall"  , data["wall"]  )
end

function Map.tile_layer__save_data(_s, p_tilemap, p_tiles) -- p_tiles[y][x]

	if u.is_emp(p_tiles) then log.pp("map.tile__", p_tiles) return end
	
	p_tilemap = p_tilemap or Map.tilemap_dflt
	
	local t_tile
	local x_min, x_max, y_min, y_max = _s:rng_tile_xy(p_tilemap)
	for y = y_min, y_max do
		
		for x = x_min, x_max do
			
			t_tile = p_tiles[int._2_str(y)][int._2_str(x)]
			map.tile__6_tile_xy(x, y, t_tile, _s._id, p_tilemap)
			
--[[
			if p_tilemap == "ground" then
				_s:tile_xy_tile__6_tile_xy(x, y, t_tile)
			end
--]]
		end
	end
end

function Map.save_data_tiles(_s)
	
	local r_tile = {}
	r_tile["ground"] = _s:save_data_tile("ground")
	r_tile["wall"]   = _s:save_data_tile("wall")
	return r_tile
end

function Map.save_data_tile(_s, p_tilemap)

	p_tilemap = p_tilemap or Map.tilemap_dflt

	local r_tiles, _tile
	r_tiles = {} -- r_tiles[y][x]
	
	local x_min, x_max, y_min, y_max = _s:rng_tile_xy(p_tilemap)
	for y = y_min, y_max do
		
		r_tiles[int._2_str(y)] = {}
		
		for x = x_min, x_max do
			
			_tile = _s:tile_6_tile_xy(x, y, p_tilemap)
			
			r_tiles[int._2_str(y)][int._2_str(x)] = _tile
		end
	end
	
	return r_tiles
end

-- rng_tilepos

function Map.rng_tilepos(_s, p_tilemap)

	if _s._rng_tilepos then return _s._rng_tilepos end

	p_tilemap = p_tilemap or Map.tilemap_dflt

	_s._rng_tilepos = map.rng_tilepos(_s._id, p_tilemap)
	return _s._rng_tilepos
end

function Map.rng_tile_xy(_s, p_tilemap)
	
	p_tilemap = p_tilemap or Map.tilemap_dflt
	
	return map.rng_tile_xy(_s._id, p_tilemap)
end

-- tile__crct

function Map.tile__crct(_s, p_tilepos, p_tilemap, layer)

	local tile_cntr = map.tile_6_tile_xy(p_tilepos.x, p_tilepos.y, _s._id, p_tilemap, layer)
	
	local is_tile_bndl, tile_base = Tile_bndl.is_tile_bndl(tile_cntr)

	if not is_tile_bndl then return end

	-- tile bndl
	
	local tile_arund_bndl_code = _s:tile_arund_bndl_code(p_tilepos)
	local tile_crct = Tile_bndl.tile_crct(tile_base, tile_arund_bndl_code)

	local t_url = url._(_s._id, p_tilemap)
	tile.__(t_url, layer, p_tilepos.x, p_tilepos.y, tile_crct)
end

function Map.tile_arund_bndl_flg(_s, p_tilepos, p_tile)

	p_tile = p_tile or map.tile_6_tile_xy(p_tilepos.x, p_tilepos.y, _s._id, "ground")

	local base_tile = Tile_bndl.base_tile(p_tile)

	if not base_tile then return end

	-- arund_tile
	
	local tilepos_arund = Map.tilepos_arund(p_tilepos)

	local tile_arund_bndl = {}
	
	local t_tile, t_tilepos, is_base_tile_bndl

	for idx, t_tilepos in pairs(tilepos_arund) do

		t_tile = map.tile_6_tile_xy(t_tilepos.x, t_tilepos.y, _s._id, "ground")

		if t_tile then
			is_base_tile_bndl = Tile_bndl.is_base_tile_bndl(t_tile, base_tile)
		else
			is_base_tile_bndl = _.f
		end

		ar.add(tile_arund_bndl, is_base_tile_bndl)
	end
	
	return tile_arund_bndl
end

function Map.tile_arund_bndl_code(_s, p_tilepos)

	local tile_cntr = map.tile_6_tile_xy(p_tilepos.x, p_tilepos.y, _s._id, "ground")
	local base_tile = Tile_bndl.base_tile(tile_cntr)
	
	if not base_tile then return end

	local tile_arund_bndl_flg  = _s:tile_arund_bndl_flg(p_tilepos)
	local tile_arund_bndl_code = Tile_bndl.arund_flg_2_arund_code(tile_arund_bndl_flg)

	return tile_arund_bndl_code
end

-- tile crct static

function Map.tilepos_arund(p_tilepos) -- todo cache

--[[
	local tilepos_arund = {
		t.vec_i(p_tilepos.x - 1, p_tilepos.y + 1, nil, 1, "Map.tilepos_arund"),
		t.vec_i(p_tilepos.x + 0, p_tilepos.y + 1, nil, 2, "Map.tilepos_arund"),
		t.vec_i(p_tilepos.x + 1, p_tilepos.y + 1, nil, 3, "Map.tilepos_arund"),

		t.vec_i(p_tilepos.x - 1, p_tilepos.y    , nil, 4, "Map.tilepos_arund"),
		t.vec_i(p_tilepos.x + 1, p_tilepos.y    , nil, 5, "Map.tilepos_arund"),

		t.vec_i(p_tilepos.x - 1, p_tilepos.y - 1, nil, 6, "Map.tilepos_arund"),
		t.vec_i(p_tilepos.x + 0, p_tilepos.y - 1, nil, 7, "Map.tilepos_arund"),
		t.vec_i(p_tilepos.x + 1, p_tilepos.y - 1, nil, 8, "Map.tilepos_arund"),
	}
--]]
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

-- log

function Map.log_tile_xy(_s, x, y)
	
	local is_inside, dir = map.is_inside_tile_xy(x, y, _s._id, "ground")
	
	if not is_inside then return end

	log.pp(
		"log_tile_xy",
		_s._tile[y][x - 1],
		_s._tile[y][x    ],
		_s._tile[y][x + 1]
		-- _s._tile[y + 1][x    ],
		-- _s._tile[y - 1][x    ]
	)
end

