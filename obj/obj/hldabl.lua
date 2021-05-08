log.scrpt("hldabl.lua")

Hldabl = {}

-- script method

function Hldabl.__init(_s)

	_s._hldd_id  = nil
	_s._hldd_idx = nil
end

function Hldabl.on_msg(_s, msg_id, prm, sndr_url)

	if     ha.eq(msg_id, "hldd__o") then
		_s:hldd__o(prm)

	elseif ha.eq(msg_id, "hldd__x") then
		_s:hldd__x()
	end
end

function Hldabl.hldd__o(_s, prm)
	
	_s._hldd_id  = prm.hldd_id
	_s._hldd_idx = prm.hldd_idx
	-- log._("hldabl.hld__o", _s._hldd_id, _s._hldd_idx)
	
	_s:anm_cancel_pos()
	
	if _s:is_food() and _s._kitchen_id then
		pst.scrpt(_s._kitchen_id, "kitchen__x", {id = _s._id})
		_s:kitchen__x()
	end
	
	if _s._bear_tree_id then
		pst.scrpt(_s._bear_tree_id, "bear__x", {bear_id = _s._id})
		_s._bear_tree_id = nil
	end

	local z = - 0.01
	local t_pos = _s:hldd_pos()
	_s:parent__(_s:plychara_id(), z, t_pos)
	-- log._("hldabl hldd__o pos", _s:pos())
end

function Hldabl.hldd_pos(_s)
	
	local x

	-- local weight = id.Cls_prp_weight(_s._id)

	if _s._weight == 1 then
		x = u.x_by_all_w(_s._hldd_idx, Plychara.hld_idx_max, Map.sqh)
	else
		x = 0
	end

	local y
	if ar.inHa(_s:cls(), {"kagu"}) then
		y = _s:foot_dst_i()
	else
		y = Map.sqh
	end

	local t_pos = n.vec(x, y)
	return t_pos
end

function Hldabl.hldd__x(_s)
	
	_s._hldd_id  = nil
	_s._hldd_idx = nil
	_s:parent__map()
end

function Hldabl.final(_s)

	if _s._hldd_id then
		pst.scrpt(_s._hldd_id, "hld__del", {id = _s._id})
		_s._hldd_id = nil
	end
end

