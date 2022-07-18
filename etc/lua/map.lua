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

	local x, y = map.pos_xy_6_tile_xy(p_tilepos.x, p_tilepos.y)
	return x, y
end

function map.pos_xy_6_tile_xy(p_tile_x, p_tile_y)

	local x = Map.sq * p_tile_x - Map.sqh
	local y = Map.sq * p_tile_y - Map.sqh
	return x, y
end

-- tile center pos

function map.pos_xy_6_pos(p_pos) -- old

	local x, y = map.tile_pos_xy_6_pos(p_pos)
	return x, y
end

function map.tile_pos_xy_6_pos(p_pos) -- tile center pos

	local tile_x, tile_y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)

	local x, y = map.pos_xy_6_tile_xy(tile_x, tile_y)
	return x, y
end

-- tilepos

function map.tile_xy_6_pos_xy(p_pos_x, p_pos_y)

	local x = map.tile_x_6_pos_x(p_pos_x)
	local y = map.tile_x_6_pos_x(p_pos_y)
	return x, y
end

function map.tile_x_6_pos_x(p_pos_x)

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
	
	local tile_x, tile_y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)

	local t_tile = map.tile_6_tile_xy(tile_x, tile_y, p_id, p_tilemap, layer)
	return t_tile
end

function map.tile_6_tile_xy(x, y, p_id, p_tilemap, layer)

	p_tilemap = p_tilemap or Map.tilemap_dflt
	layer = layer or p_tilemap

	local is_inside, dir = map.is_inside_tile_xy(x, y, p_id, p_tilemap)
	
	if not is_inside then return end

	local t_url = url._(p_id, p_tilemap)
	local t_tile = tilemap.get_tile(t_url, layer, x, y)
	return t_tile
end

function map.tile__(p_pos, p_tile, p_id, p_tilemap, layer)

	layer = layer or p_tilemap
	
	local x, y = map.tile_xy_6_pos_xy(p_pos.x, p_pos.y)

	map.tile__6_tile_xy(x, y, p_tile, p_id, p_tilemap, layer)
end

function map.tile__6_tilepos(p_tilepos, p_tile, p_id, p_tilemap, layer) -- rpl

	map.tile__6_tile_xy(p_tilepos.x, p_tilepos.y, p_tile, p_id, p_tilemap, layer) -- todo mod
end

function map.tile__6_tile_xy(x, y, p_tile, map_id, p_tilemap, layer)

	layer = layer or p_tilemap

	local is_inside, dir = map.is_inside_6_tile_xy(x, y, map_id, p_tilemap)
	if not is_inside then return end

	local t_url = url._(map_id, p_tilemap)
	tile.__(t_url, layer, x, y, p_tile)
end

-- is_inside

function map.is_inside_6_pos_xy(p_pos_x, p_pos_y, p_id, p_tilemap)

	local tile_x, tile_y = map.tile_xy_6_pos_xy(p_pos_x, p_pos_y)

	local ret, dir = map.is_inside_tile_xy(tile_x, tile_y, p_id, p_tilemap)
	return ret, dir
end

function map.is_inside_6_tile_xy(p_tile_x, p_tile_y, p_id, p_tilemap)

	local ret, dir = map.is_inside_tile_xy(p_tile_x, p_tile_y, p_id, p_tilemap)
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

function map.is_inside_tile_xy(x, y, p_id, p_tilemap)

	local rng_tilepos = map.rng_tilepos(p_id, p_tilemap)
	local ret, dir = map.is_inside_tile_xy_cmpr(x, y, rng_tilepos)
	return ret, dir
end

function map.is_inside_tile_xy_cmpr(x, y, rng_tilepos)

	local ret, dir = _.t, nil

	if     x < rng_tilepos.min.x then
		ret, dir = _.f, "l"
	elseif x > rng_tilepos.max.x then
		ret, dir = _.f, "r"
	elseif y < rng_tilepos.min.y then
		ret, dir = _.f, "d"
	elseif y > rng_tilepos.max.y then
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

function map.rng_tilepos(map_id, p_tilemap)

	if  map._[p_tilemap]
	and map._[p_tilemap].rng_tilepos then
		return map._[p_tilemap].rng_tilepos
	end

	ar.chld_ar__init_if_nil(map._, p_tilemap)
	
	local x, y, w, h = map.tile_bound(map_id, p_tilemap)
	local min = {x = x        , y = y        }
	local max = {x = x + w - 1, y = y + h - 1}

	map._[p_tilemap].rng_tilepos = {min = min, max = max}
	
	return map._[p_tilemap].rng_tilepos
end

function map.rng_tile_xy(map_id, p_tilemap)
	
	local r = map.rng_tilepos(map_id, p_tilemap)
	return r.min.x, r.max.x, r.min.y, r.max.y
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

-- old

--[[
function map.is_inside(p_pos, p_id, p_tilemap, tilesize) -- use not

	local inside_rng_pos = map.inside_rng_pos(p_id, p_tilemap, tilesize)

	local ret, dir = map.is_inside_cmpr(p_pos, inside_rng_pos)
	return ret, dir
end
--]]

