log.script("hldabl.lua")

Hldabl = {}

-- script method

function Hldabl.init(_s)
	_s._hld_id  = nil
	_s._hld_idx = nil
end

function Hldabl.on_msg(_s, msg_id, prm, sender)

	if     ha.eq(msg_id, "hld__o") then
		_s:hld__o(prm)

	elseif ha.eq(msg_id, "hld__x") then
		_s:hld__x()
	end
end

function Hldabl.hld__o(_s, prm)
	
	_s._hld_id  = prm.hld_id
	_s._hld_idx = prm.hld_idx
	log._("hldabl.hld__o", _s._hld_id, _s._hld_idx)
	
	_s:anm_cancel_pos()
	
	if _s:is_food() and _s._kitchen_id then
		pst.script(_s._kitchen_id, "kitchen_x", {id = _s._id})
		_s:kitchen_x()
	end
	
	if _s._bear_tree_id then
		pst.script(_s._bear_tree_id, "bear_x", {bear_id = _s._id})
		_s._bear_tree_id = nil
	end

	local z = - 0.01
	local t_pos = _s:hld_pos()
	_s:parent__(_s:plychara_id(), z, t_pos)
	-- log._("hldabl hld__o pos", _s:pos())
end

function Hldabl.hld_pos(_s)
	
	local x = u.x_by_all_w(_s._hld_idx, Plychara.hld_idx_max, Map.sqh)
	local y
	if ar.inHa(_s:cls(), {"kagu"}) then
		y = _s:foot_dst_i()
	else
		y = Map.sqh
	end
	local pos = n.vec(x, y)
	return pos
end

function Hldabl.hld__x(_s)
	
	_s._hld_id  = nil
	_s._hld_idx = nil
	_s:parent__map()
end

function Hldabl.final(_s)

	if _s._hld_id then
		pst.script(_s._hld_id, "hld__del", {id = _s._id})
		_s._hld_id = nil
	end
end

--[[
function Hldabl.hld_pos__(_s, p_pos)
	p_pos = p_pos or _s:hld_pos()
	pst.script(_s._id, "pos__", {pos = p_pos})
end
--]]
