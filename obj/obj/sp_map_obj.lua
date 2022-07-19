log.scrpt("sp_map_obj.lua")

-- map obj

function Sp.map_obj__add(_s)
	
	if not _s._cls then return end
	
	local prm = {
		id  = _s._id,
		cls = _s._cls,
	}
	pst.scrpt(_s:map_id(), "obj__add", prm)
end

function Sp.map_obj__del(_s)

	local prm = {
		id  = _s._id,
		cls = _s._cls,
	}
	pst.scrpt(_s:map_id(), "obj__del", prm)
end

function Sp.map_tile_xy_obj__add(_s)
	
	if not _s:is_parent_eq_map() then return end

	local prm = {id = _s._id, cls = _s._cls, pos = _s:pos()}
	pst.scrpt(_s:map_id(), "tile_xy_obj__add", prm)
end

function Sp.map_tile_xy_obj__del(_s)
	
	local prm = { id  = _s._id, cls = _s._cls, pos = _s:pos()}
	pst.scrpt(_s:map_id(), "tile_xy_obj__del", prm)
end

function Sp.obj_arund(_s, clsHa) -- todo mod -- use not

--[[
	local obj = Mapobj.obj_arund(_s:tilepos(), clsHa)
	return obj
--]]
end

function Sp.obj_d(_s, clsHa) -- todo mod -- use not

	local obj = Mapobj.obj(_s:tilepos_d(), clsHa)
	return obj
end

