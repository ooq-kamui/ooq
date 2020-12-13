log.script("holdable.lua")

Holdable = {}

-- script method

function Holdable.init(_s)
	_s._hold_id  = nil
	_s._hold_idx = nil
end

function Holdable.on_msg(_s, msg_id, prm, sender)

	if     ha.eq(msg_id, "hold__o") then
		_s:hold__o(prm)

	elseif ha.eq(msg_id, "hold__x") then
		_s:hold__x()
	end
end

function Holdable.hold__o(_s, prm)
	
	_s._hold_id  = prm.hold_id
	_s._hold_idx = prm.hold_idx
	log._("holdable.hold__o", _s._hold_id, _s._hold_idx)
	
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
	local t_pos = _s:hold_pos()
	_s:parent__(_s:plychara_id(), z, t_pos)
	-- log._("holdable hold__o pos", _s:pos())
end

function Holdable.hold_pos(_s)
	
	local x = u.x_by_all_w(_s._hold_idx, Plychara.hold_max, Map.sqh)
	local y
	if ar.inHa(_s:cls(), {"kagu"}) then
		y = _s:foot_dst_i()
	else
		y = Map.sqh
	end
	local pos = n.vec(x, y)
	return pos
end

function Holdable.hold__x(_s)
	
	_s._hold_id  = nil
	_s._hold_idx = nil
	_s:parent__map()
end

function Holdable.final(_s)
	if _s._hold_id then
		pst.script(_s._hold_id, "hold__x", {id = _s._id})
		_s._hold_id = nil
	end
end

--[[
function Holdable.hold_pos__(_s, p_pos)
	p_pos = p_pos or _s:hold_pos()
	pst.script(_s._id, "pos__", {pos = p_pos})
end
--]]
