log.scrpt("food.lua")

Food = {
	cls = {"dairy","dish","egg","fish","fruit","meat","veget",},
	cookabl = {"dairy","dish","egg","fish","fruit","meat","veget",},
}

function Food.cre_by_cls(p_pos, prm)
	
	p_pos = p_pos or Game.plychara_pos()
	-- log.pp("food cre_by_cls", prm)
	Cls._(prm._clsHa).cre(p_pos, prm)
end

-- script method

function Food.__init(_s)
	_s._kitchen_id = nil
end

function Food.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)

	if     ha.eq(msg_id, "kitchen__o")    then
		_s:kitchen__o(prm.id)
	
	elseif ha.eq(msg_id, "kitchen__x")    then
		_s:kitchen__x()
	
	elseif ha.eq(msg_id, "into_reizoko") then
		_s:into_reizoko(prm.id)

	elseif ha.eq(msg_id, "cook_to_dish") then
		_s:cook_to_dish()
	
	elseif ha.eq(msg_id, "bear__o")      then
		_s:bear__o(prm.tree_id)
	
	elseif ha.eq(msg_id, "bear__x")      then
		_s:bear__x()
	end
end

function Food.final(_s)

	Sp.final(_s)
	Hldabl.final(_s)

	if     _s._kitchen_id then
		pst.scrpt(_s._kitchen_id, "kitchen__x", {id = _s._id})
	
	elseif _s._bear_tree_id then
		pst.scrpt(_s._bear_tree_id, "bear__x", {bear_id = _s._id})
	end
end

-- method

function Food.into_reizoko(_s, reizoko_id)
	_s:del()
end

function Food.kitchen__o(_s, kitchen_id)
	_s._kitchen_id = kitchen_id
end

function Food.kitchen__x(_s)
	_s._kitchen_id = nil
	pst.parent__(_s._id, _s._map_id, Cls._(_s._clsHa).z)
end

function Food.cook_to_dish(_s)
	_s._kitchen_id = nil
	_s:del()
end

function Food.bear__o(_s, tree_id)
	
	_s._bear_tree_id = tree_id
	pst.parent__(_s._id, tree_id, 0.05)
	
	_s:anm_scl__1()
	-- _s:scl__1()
end

function Food.bear__x(_s)
	
	_s._bear_tree_id = nil

	local z = _s:Cls().z or 0.2
	pst.parent__(_s._id, _s._map_id, z)
end

