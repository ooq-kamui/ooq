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

--[[
function Sp.cls_is_mapobj(_s)
	
	local ret = ar.in_(_s._cls, Mapobj.cls)
	return ret
end

function Sp.mapobj__del(_s) -- use not

	if not _s:cls_is_mapobj() then return end

	Mapobj.del(_s:tilepos(), _s._clsHa, _s._id)
end

function Sp.mapobj__(_s) -- old -- use not
	-- log._("sp mapobj__")

	if not _s:cls_is_mapobj() then return end
	
	local t_tilepos = _s:tilepos()
	
	Mapobj.__(t_tilepos, _s._clsHa, _s._id)
	
	if _s._tilepos_pre
	and ((t_tilepos.x ~= _s._tilepos_pre.x) or (t_tilepos.y ~= _s._tilepos_pre.y)) then
		Mapobj.del(_s._tilepos_pre, _s._clsHa, _s._id)
	end
	
	_s._tilepos_pre = t_tilepos
end

function Sp.is_on_obj_block(_s) -- use not

	local ret = _.f
	
	local block = _s:obj_d(ha._("block"))

	local block_id
	for id, val in pairs(block) do
		block_id = id
		break
	end

	if not block_id then return ret, nil end

	local block_pos = id.pos(block_id)
	
	if num.is_rng(_s:foot_o_pos().y, {block_pos.y + Map.sqh*3/4, block_pos.y + Map.sqh}) then
		ret = _.t
	else
		return ret, nil
	end
	return ret, block_id
end
--]]

