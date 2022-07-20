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

-- map gtile

function Sp.map_gtile_obj__add(_s)
	
	if not _s:is_parent_eq_map() then return end

	local prm = {id = _s._id, cls = _s._cls, pos = _s:pos()}
	pst.scrpt(_s:map_id(), "gtile_obj__add", prm)
end

function Sp.map_gtile_obj__del(_s)
	
	local prm = { id  = _s._id, cls = _s._cls, pos = _s:pos()}
	pst.scrpt(_s:map_id(), "gtile_obj__del", prm)
end

-- gtile

function Sp.gtile__init(_s)
	
	_s:gtile__()

	_s:map_gtile_obj__add() -- mod
end

function Sp.gtile__(_s)
	
	_s._gtile = Game.gtile()
end

function Sp.gtile(_s, x, y, dx, dy)
	
	x, y = _s:gtile_prm_dflt(x, y)
	
	return Game.gtile(x, y, dx, dy)
end

function Sp.gtile_obj(_s, x, y, p_cls)
	
	-- local x, y = _s:gtile_prm_dflt(x, y)
	
	local ret
	if p_cls then
		r_obj = _s:gtile(x, y)["obj"][p_cls]
		if not r_obj then
			r_obj = {}
		end
	else
		r_obj = _s:gtile(x, y)["obj"]
	end
	return r_obj
end

function Sp.gtile_obj_cls(_s, p_cls, x, y)
	
	-- local x, y = _s:gtile_prm_dflt(x, y)
	
	return _s:gtile_obj(x, y, p_cls)
end

function Sp.gtile_obj_othr1(_s, p_cls, dir, x, y, dx, dy)
	
	x, y = _s:gtile_prm_dflt(x, y)
	
	dx = dx or 0
	dy = dy or 0
	
	local x_s = x - dx
	local x_e = x + dx
	local y_s = y - dy
	local y_e = y + dy
	
	local x_min, x_max, y_min, y_max = map.rng_tile_xy(_s:map_id(), "ground")
	if x_s < x_min then x_s = x_min end
	if x_e > x_max then x_e = x_max end
	if y_s < y_min then y_s = y_min end
	if y_e > y_max then y_e = y_max end
	
	local r_id, t_pos_y
	local s_pos_y = _s:pos_y()
	local t_obj
	
	for x_idx = x_s, x_e do
		
		t_obj = _s:gtile_obj_cls(_s._cls, x_idx, y)
		
		for _id, val in pairs(t_obj) do
			
			if not (_id == _s._id) then
				
				if not dir then
					r_id = _id
					return r_id
					-- break
				else
					t_pos_y = id.pos_y(_id)
					if dir == "d" and t_pos_y <= s_pos_y then
						r_id = _id
						return r_id
						-- break
					end
				end
			end
		end
	end
	-- log.if_(r_id, "Sp.gtile_obj_cls_othr_1", y, x, _s._id, r_id, s_pos_y, t_pos_y)
	return r_id
end

function Sp.gtile_prm_dflt(_s, x, y)

	if not (x and y) then
	
		local c_x, c_y = _s:tile_xy()
		x = x or c_x
		y = y or c_y
	end
	return x, y
end

function Sp.obj_arund(_s, clsHa) -- todo mod -- use not
end

function Sp.obj_d(_s, clsHa) -- todo mod -- use not
end

