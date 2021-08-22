log.scrpt("map.lua")

map = {
	_ = {}, -- cache - [tilemap][bound]
}

function map.pos_6_tilepos(p_tilepos) -- rpl must > map.pos_xy_6_tilepos

	local x, y = map.pos_xy_6_tilepos(p_tilepos) -- rpl must
	local t_pos = n.vec(x, y, nil, "map.pos_6_tilepos")
	return t_pos
end

function map.pos_xy_6_tilepos(p_tilepos)

	local x, y = map.pos_xy_6_tilepos_xy(p_tilepos.x, p_tilepos.y)
	return x, y
end

function map.pos_xy_6_tilepos_xy(p_tilepos_x, p_tilepos_y)

	local x = Map.sq * p_tilepos_x - Map.sqh
	local y = Map.sq * p_tilepos_y - Map.sqh
	return x, y
end

-- tile center pos

function map.pos_xy_6_pos(p_pos) -- old

	local x, y = map.tile_pos_xy_6_pos(p_pos)
	return x, y
end

function map.tile_pos_xy_6_pos(p_pos) -- tile center pos

	local tilepos_x, tilepos_y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)

	local x, y = map.pos_xy_6_tilepos_xy(tilepos_x, tilepos_y)
	return x, y
end

-- tilepos

function map.tilepos_xy_6_pos_xy(p_pos_x, p_pos_y)

	-- local x = math.floor( (p_pos.x + Map.sq) / Map.sq )
	-- local y = math.floor( (p_pos.y + Map.sq) / Map.sq )

	local x = map.tilepos_x_6_pos_x(p_pos_x)
	local y = map.tilepos_x_6_pos_x(p_pos_y)

	-- local x = 1 -- dbg
	-- local y = 1 -- dbg
	return x, y
end

function map.tilepos_x_6_pos_x(p_pos_x)

	local x = math.floor( (p_pos_x + Map.sq) / Map.sq )
	return x
end

function map.tile(p_pos, p_id, p_tilemap, layer, obj_id) -- alias

	local t_tile = map.tile_6_pos(p_pos, p_id, p_tilemap, layer, obj_id)
	return t_tile
end

function map.tile_6_pos(p_pos, p_id, p_tilemap, layer, obj_id)
	-- log.if_(ha.eq(obj_id, "/instance11"), "map.tile", obj_id)
	-- log._("map.tile")

	p_tilemap = p_tilemap or Map.tilemap_dflt
	layer     = layer     or p_tilemap

	local is_inside, dir = map.is_inside_6_pos_xy(p_pos.x, p_pos.y, p_id, p_tilemap)
	-- local is_inside, dir = _.t, nil -- dbg
	if not is_inside then return end
	
	local tilepos_x, tilepos_y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)

	local t_tile = map.tile_6_tilepos_xy(tilepos_x, tilepos_y, p_id, p_tilemap, layer)
	return t_tile
end

function map.tile_6_tilepos_xy(tilepos_x, tilepos_y, p_id, p_tilemap, layer)
	-- log._("map.tile_6_tilepos_xy")

	p_tilemap = p_tilemap or Map.tilemap_dflt
	layer = layer or p_tilemap

	local is_inside, dir = map.is_inside_tilepos_xy(tilepos_x, tilepos_y, p_id, p_tilemap)
	-- local is_inside, dir = _.t, nil -- dbg
	if not is_inside then return end

	local t_url = url._(p_id, p_tilemap)
	local t_tile = tilemap.get_tile(t_url, layer, tilepos_x, tilepos_y)
	-- local t_tile = 1 -- dbg
	return t_tile
end

function map.tile__(p_pos, p_tile, p_id, p_tilemap, layer)

	layer = layer or p_tilemap
	
	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)

	map.tile__6_tilepos_xy(x, y, p_tile, p_id, p_tilemap, layer)
end

function map.tile__6_tilepos_xy(tilepos_x, tilepos_y, p_tile, p_id, p_tilemap, layer)
	log._("map.tile__6_tilepos_xy")

	local p_tilepos = n.vec(tilepos_x, tilepos_y, nil, "map.tile__6_tilepos_xy")
	map.tile__6_tilepos(p_tilepos, p_tile, p_id, p_tilemap, layer) -- todo mod
end

function map.tile__6_tilepos(p_tilepos, p_tile, p_id, p_tilemap, layer) -- rpl

	layer = layer or p_tilemap

	-- log._("map.tile__6_tilepos")
	local is_inside, dir = map.is_inside_6_tilepos_xy(p_tilepos.x, p_tilepos.y, p_id, p_tilemap)
	if not is_inside then return end

	local tile_prv = map.tile_6_tilepos_xy(p_tilepos.x, p_tilepos.y, p_id, p_tilemap, layer)
	
	local t_url = url._(p_id, p_tilemap)
	tilemap.set_tile(t_url, layer, p_tilepos.x, p_tilepos.y, p_tile)

	if not (p_tilemap == "ground" and layer == "ground") then return end

	
	Map.tile__crct(p_tilepos, p_id, p_tilemap, layer)

	-- arund_tile__crct
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

-- is_inside

function map.is_inside(p_pos, p_id, p_tilemap, tilesize) -- use not

	local inside_rng_pos = map.inside_rng_pos(p_id, p_tilemap, tilesize)

	local ret, dir = map.is_inside_cmpr(p_pos, inside_rng_pos)
	return ret, dir
end

function map.is_inside_6_pos_xy(p_pos_x, p_pos_y, p_id, p_tilemap)

	local tilepos_x, tilepos_y = map.tilepos_xy_6_pos_xy(p_pos_x, p_pos_y)

	local ret, dir = map.is_inside_tilepos_xy(tilepos_x, tilepos_y, p_id, p_tilemap)
	return ret, dir
end

function map.is_inside_6_tilepos_xy(p_tilepos_x, p_tilepos_y, p_id, p_tilemap)

	local ret, dir = map.is_inside_tilepos_xy(p_tilepos_x, p_tilepos_y, p_id, p_tilemap)
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

function map.is_inside_tilepos_xy(p_tilepos_x, p_tilepos_y, p_id, p_tilemap)

	local rng_tilepos = map.rng_tilepos(p_id, p_tilemap)
	local ret, dir = map.is_inside_tilepos_xy_cmpr(p_tilepos_x, p_tilepos_y, rng_tilepos)
	return ret, dir
end

function map.is_inside_tilepos_xy_cmpr(p_tilepos_x, p_tilepos_y, rng_tilepos)

	local ret, dir = _.t, nil

	if     p_tilepos_x < rng_tilepos.min.x then
		ret, dir = _.f, "l"
	elseif p_tilepos_x > rng_tilepos.max.x then
		ret, dir = _.f, "r"
	elseif p_tilepos_y < rng_tilepos.min.y then
		ret, dir = _.f, "d"
	elseif p_tilepos_y > rng_tilepos.max.y then
		ret, dir = _.f, "u"
	end

	return ret, dir
end

-- rng

function map.rng_pos(p_id, p_tilemap, tilesize)
	-- log._("map.rng_pos", p_id, p_tilemap)
	
	local rng_tilepos = map.rng_tilepos(p_id, p_tilemap)
	
	-- todo cache

	local min = n.vec((rng_tilepos.min.x - 1) * tilesize.x, (rng_tilepos.min.y - 1) * tilesize.y)
	local max = n.vec((rng_tilepos.max.x    ) * tilesize.x, (rng_tilepos.max.y    ) * tilesize.y)
	return {min = min, max = max}
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
	log._("map.rng_tilepos")
	
	return map._[p_tilemap].rng_tilepos
end

function map.rng_tilepos_xy(p_id, p_tilemap)
	-- log._("map.rng_tilepos_xy")
	
	local r = map.rng_tilepos(p_id, p_tilemap)
	return r.min.x, r.max,x, r.min.y, r.max.y
end

function map.inside_rng_pos(p_id, p_tilemap, tilesize)
	-- log._("map.inside_rng_pos")

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

function map.tile_bound(p_id, p_tilemap)

	local t_url = url._(p_id, p_tilemap)
	
	local x, y, w, h = tilemap.get_bounds(t_url)
	return x, y, w, h
end

--[[
function map.pos_6_pos(p_pos) -- tile center pos -- rpl done

	local x, y = map.pos_xy_6_pos(p_pos)

	local t_pos = n.vec(x, y, nil, "map.pos_6_pos")
	return t_pos
end

function map.tilepos_6_pos(p_pos) -- rpl done

	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)

	local t_tilepos = n.vec(x, y, nil, "map.tilepos_6_pos")
	return t_tilepos
end

function map.tilepos_xy_6_pos(p_pos) -- rpl done

	local x, y = map.tilepos_xy_6_pos_xy(p_pos.x, p_pos.y)
	return x, y
end

function map.tile_6_tilepos(p_tilepos, p_id, p_tilemap, layer) -- rpl done

	return map.tile_6_tilepos_xy(p_tilepos.x, p_tilepos.y, p_id, p_tilemap, layer)
end

function map.is_inside_6_pos(p_pos, p_id, p_tilemap) -- rpl done

	local ret, dir = map.is_inside_6_pos_xy(p_pos.x, p_pos.y, p_id, p_tilemap)
	return ret, dir
end

function map.is_inside_6_tilepos(p_tilepos, p_id, p_tilemap) -- rpl done
	local ret, dir = map.is_inside_tilepos_xy(p_tilepos.x, p_tilepos.y, p_id, p_tilemap)
	return ret, dir
end

function map.is_inside_tilepos_cmpr(p_tilepos, rng_tilepos) -- rpl done

	local ret, dir = map.is_inside_tilepos_xy_cmpr(p_tilepos.x, p_tilepos.y, rng_tilepos)
	return ret, dir
end
--]]

