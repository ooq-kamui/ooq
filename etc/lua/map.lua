log.script("map.lua")

map = {
	_ = {}, -- cache - [tilemap][bound]
}

function map.pos_by_tilepos(tilepos)
	local pos = n.vec(Map.sq * tilepos.x - Map.sqh, Map.sq * tilepos.y - Map.sqh)
	return pos
end

function map.pos_2_tilepos(pos)
	local x = math.floor((pos.x + Map.sq) / Map.sq)
	local y = math.floor((pos.y + Map.sq) / Map.sq)
	local tilepos = n.vec(x, y)
	return tilepos
end

function map.tile(pos, p_id, p_tilemap, layer)

	p_tilemap = p_tilemap or Map.tilemap[1]
	layer     = layer or p_tilemap

	local tilepos = map.pos_2_tilepos(pos)

	-- log._("map.tile")
	local is_inside, dir = map.is_inside_tilepos(tilepos, p_id, p_tilemap)
	if not is_inside then return end
	
	return map.tile_by_tilepos(tilepos, p_id, p_tilemap, layer)
end

function map.tile_by_tilepos(tilepos, p_id, p_tilemap, layer)

	layer = layer or p_tilemap

	-- log._("map.tile_by_tilepos")
	local is_inside, dir = map.is_inside_tilepos(tilepos, p_id, p_tilemap)
	if not is_inside then return end
	
	local t_url = url._(p_id, p_tilemap)
	-- log._("map.tile_by_tilepos", t_url)

	local tile = tilemap.get_tile(t_url, layer, tilepos.x, tilepos.y)
	return tile
end

function map.tile__(pos, tile, p_id, p_tilemap, layer)

	layer = layer or p_tilemap
	
	local tilepos = map.pos_2_tilepos(pos)
	map.tile__by_tilepos(tilepos, tile, p_id, p_tilemap, layer)
end

function map.tile__by_tilepos(p_tilepos, p_tile, p_id, p_tilemap, layer)

	layer = layer or p_tilemap

	-- log._("map.tile__by_tilepos")
	local is_inside, dir = map.is_inside_tilepos(p_tilepos, p_id, p_tilemap)
	if not is_inside then return end

	local tile_prv = map.tile_by_tilepos(p_tilepos, p_id, p_tilemap, layer)
	
	local t_url = url._(p_id, p_tilemap)
	tilemap.set_tile(t_url, layer, p_tilepos.x, p_tilepos.y, p_tile)

	if not (p_tilemap == "ground" and layer == "ground") then return end

	
	Map.tile__crct(p_tilepos, p_id, p_tilemap, layer)

	-- arund_tile__crct
	-- log._("map.tile__by_tilepos  arund_tile__crct")
	-- local arund_ar  = map.tile_bndl_arund_ar(p_tilepos)

	local tile_bndl = p_tile == 0 and tile_prv or p_tile
	local arund_ar  = Map.arund_tile_bndl_ar(p_tilepos, tile_bndl)
	-- log.pp("arund_ar", arund_ar)
	
	if not arund_ar then return end
	
	local arund_tilepos = Map.tilepos_arund(p_tilepos)

	if arund_ar[2] then Map.tile__crct(arund_tilepos[2], p_id, p_tilemap, layer) end
	if arund_ar[4] then Map.tile__crct(arund_tilepos[4], p_id, p_tilemap, layer) end
	if arund_ar[5] then Map.tile__crct(arund_tilepos[5], p_id, p_tilemap, layer) end
	if arund_ar[7] then Map.tile__crct(arund_tilepos[7], p_id, p_tilemap, layer) end
end

function map.is_inside_tilepos(tilepos, p_id, p_tilemap)
	-- log._("map.is_inside_tilepos")

	local rng_tilepos = map.rng_tilepos(p_id, p_tilemap)

	local ret, dir = map.is_inside_tilepos_cmpr(tilepos, rng_tilepos)
	return ret, dir
end

function map.is_inside_tilepos_cmpr(tilepos, rng_tilepos)

	local ret, dir = _.t, nil

	if     tilepos.x < rng_tilepos.min.x then
		ret, dir = _.f, "l"
	elseif tilepos.x > rng_tilepos.max.x then
		ret, dir = _.f, "r"
	elseif tilepos.y < rng_tilepos.min.y then
		ret, dir = _.f, "d"
	elseif tilepos.y > rng_tilepos.max.y then
		ret, dir = _.f, "u"
	end

	return ret, dir
end

function map.pos_by_pos(pos)
	local tilepos = map.pos_2_tilepos(pos)
	return map.pos_by_tilepos(tilepos)
end

function map.tile_bound(p_id, p_tilemap)
	-- log._("map tile_bound", p_id, p_tilemap)

	local t_url = url._(p_id, p_tilemap)
	-- log._("map.tile_bound", t_url, p_id, p_tilemap)
	
	local x, y, w, h = tilemap.get_bounds(t_url)
	-- map._[p_id][p_tilemap] = {x = x, y = y, w = w, h = h}
	
	return x, y, w, h
end

function map.rng_tilepos_xy(p_id, p_tilemap)
	-- log._("map.rng_tilepos_xy")
	
	local r -- rng_tilepos 
	r = map.rng_tilepos(p_id, p_tilemap)
	return r.min.x, r.max,x, r.min.y, r.max.y
end

function map.rng_tilepos(p_id, p_tilemap)

	if map._[p_tilemap] and map._[p_tilemap].rng_tilepos then return map._[p_tilemap].rng_tilepos end

	if not map._[p_tilemap] then
		-- log._("map.rng_tilepos", p_tilemap)
		map._[p_tilemap] = {} 
	end
	
	local x, y, w, h = map.tile_bound(p_id, p_tilemap)
	local min = {x = x        , y = y        }
	local max = {x = x + w - 1, y = y + h - 1}

	map._[p_tilemap].rng_tilepos = {min = min, max = max}
	-- log._("map.rng_tilepos", min.x, min.y, max.x, max.y)
	
	return map._[p_tilemap].rng_tilepos
end

function map.rng_pos(p_id, p_tilemap, tilesize)
	-- if p_tilemap == "ground" then log._("map rng_pos", p_id, p_tilemap) end
	
	local rng_tilepos = map.rng_tilepos(p_id, p_tilemap)
	
	local min = n.vec((rng_tilepos.min.x - 1) * tilesize.x, (rng_tilepos.min.y - 1) * tilesize.y)
	local max = n.vec((rng_tilepos.max.x    ) * tilesize.x, (rng_tilepos.max.y    ) * tilesize.y)
	return {min = min, max = max}
end

function map.inside_rng_pos(p_id, p_tilemap, tilesize)

	local map_rng_pos = map.rng_pos(p_id, p_tilemap, tilesize)

	-- todo cache
	
	local inside_rng_pos = {
		min = {
			x = map_rng_pos.min.x + Map.inside.mrgn.l,
			y = map_rng_pos.min.y + Map.inside.mrgn.d,
		},
		max = {
			x = map_rng_pos.max.x - Map.inside.mrgn.r,
			y = map_rng_pos.max.y - Map.inside.mrgn.u,
		},
	}
	return inside_rng_pos
end

function map.is_inside(p_pos, p_id, p_tilemap, tilesize)

	local inside_rng_pos = map.inside_rng_pos(p_id, p_tilemap, tilesize)

	local ret, dir = map.is_inside_cmpr(p_pos, inside_rng_pos)
	return ret, dir
end

function map.is_inside_cmpr(p_pos, inside_rng_pos)

	local ret, dir = _.t, nil

	if     p_pos.x < inside_rng_pos.min.x then
		ret, dir = _.f, "l"
		
	elseif p_pos.x > inside_rng_pos.max.x then
		ret, dir = _.f, "r"
		
	elseif p_pos.y < inside_rng_pos.min.y then
		ret, dir = _.f, "d"
		
	elseif p_pos.y > inside_rng_pos.max.y then
		ret, dir = _.f, "u"
	end
	return ret, dir
end
