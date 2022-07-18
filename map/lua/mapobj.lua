log.scrpt("mapobj.lua")

-- 
-- old
-- 

Mapobj = {
	
	cls = {"wood", "dryleaf", "leaf", "block"}, -- use by fire , block

	_obj_ = {},

	_map_rng_tilepos = nil,

	_map_id = nil,
}

function Mapobj.init(map_id)
	-- log._("Mapobj init")

	local tilemap = "ground"
	
	Mapobj._map_id = map_id
	
	local rng_tilepos = map.rng_tilepos(map_id, tilemap)
	Mapobj.map_rng_tilepos__(rng_tilepos)
	
	local x_min, x_max, y_min, y_max = map.rng_tilepos_xy(map_id, tilemap)
	
	for y = y_min, y_max do
		
		Mapobj._obj_[y] = {}
		
		for x = x_min, x_max do
			Mapobj._obj_[y][x] = {}
		end
	end
end

function Mapobj.map_rng_tilepos__(rng_tilepos)
	
	Mapobj._map_rng_tilepos = rng_tilepos
end

function Mapobj.__(tilepos, cls, id)

	if tilepos.y > Mapobj._map_rng_tilepos.max.y then return end
	
	if not Mapobj._obj_[tilepos.y][tilepos.x][cls] then
		Mapobj._obj_[tilepos.y][tilepos.x][cls] = {}
	end
	Mapobj._obj_[tilepos.y][tilepos.x][cls][id] = _.t
	
	-- log._(Mapobj._obj_[tilepos.y][tilepos.x][cls])
end

function Mapobj.del(tilepos, cls, id)

	if tilepos.y > Mapobj._map_rng_tilepos.max.y then return end
	
	if not Mapobj._obj_[tilepos.y][tilepos.x][cls]     then return end
	if not Mapobj._obj_[tilepos.y][tilepos.x][cls][id] then return end
	
	Mapobj._obj_[tilepos.y][tilepos.x][cls][id] = nil
end

function Mapobj.obj(tilepos, clsHa)

	local is_inside, dir = map.is_inside_tilepos_xy_cmpr(tilepos.x, tilepos.y, Mapobj._map_rng_tilepos)
	
	if not is_inside then return {} end

	-- log._("Mapobj.obj()", tilepos)
	if not Mapobj._obj_[tilepos.y][tilepos.x][clsHa] then
		Mapobj._obj_[tilepos.y][tilepos.x][clsHa] = {}
	end
	
	local obj = Mapobj._obj_[tilepos.y][tilepos.x][clsHa]
	return obj
end

function Mapobj.obj_arund(p_tilepos, clsHa)
	
	local tilepos_arund = Map.tilepos_arund(p_tilepos)

	local obj_arund = {}
	local obj
	for idx, tilepos in pairs(tilepos_arund) do
		obj = Mapobj.obj(tilepos, clsHa)
		ar.key_mrg(obj_arund, obj)
	end
	
	return obj_arund
end

