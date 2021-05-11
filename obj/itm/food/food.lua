log.scrpt("food.lua")

Food = {

	cls = {"dairy","dish","egg","fish","fruit","meat","veget",},

	cookabl = {"dairy","dish","egg","fish","fruit","meat","veget",},
}
Map._obj.grp_cls.food = Food.cls

-- static

function Food.cre_by_cls(p_pos, prm)
	
	p_pos = p_pos or Game.plychara_pos()

	local t_Cls = Cls.Cls(prm._cls)
	log.pp("food cre_by_cls", prm)
	prm._cls = nil

	local t_id = t_Cls.cre(p_pos, prm)
	return t_id
end

-- script method

function Food.__init(_s)
	_s._kitchen_id = nil
end

function Food.on_msg(_s, msg_id, prm, sndr_url)
	
	local st

	st = Sp.on_msg(_s, msg_id, prm, sndr_url)
	if st then return end

	Hldabl.on_msg(_s, msg_id, prm, sndr_url)

	if     ha.eq(msg_id, "kitchen__o") then
		_s:kitchen__o(prm.id)
	
	elseif ha.eq(msg_id, "kitchen__x") then
		_s:kitchen__x()
	
	elseif ha.eq(msg_id, "__into_reizoko") then
		_s:__into_reizoko()

	elseif ha.eq(msg_id, "cook_to_dish")   then
		_s:cook_to_dish()
	
	elseif ha.eq(msg_id, "bear__o") then
		_s:bear__o(prm.tree_id)
	
	elseif ha.eq(msg_id, "bear__x") then
		_s:bear__x()

	elseif ha.eq(msg_id, "__presentd") then
		_s:__presentd(prm)
	end
end

function Food.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)

	if     _s._kitchen_id then
		pst.scrpt(_s._kitchen_id, "kitchen__x", {id = _s._id})
	
	elseif _s._bear_tree_id then
		pst.scrpt(_s._bear_tree_id, "bear__x", {bear_id = _s._id})
	end
end

-- method

function Food.__into_reizoko(_s)

	if not ar.in_(_s._cls, Food.cls) then return end
	
	Ply_data.reizoko.__add({_cls = _s._cls, _name = _s._name})

	_s:del()

	-- log pst.scrpt(_s._map_id, "obj_cnt_all")
end

function Food.kitchen__o(_s, kitchen_id)

	_s._kitchen_id = kitchen_id
end

function Food.kitchen__x(_s)

	_s._kitchen_id = nil
	pst.parent__(_s._id, _s._map_id, Cls.Cls(_s._cls).z)
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

function Food.__presentd(_s, prm)
	log._("Food.__presentd ", prm._cls, prm._name, _s._cls, _s._name)

	if prm._cls ~= "anml" then return end

	local is_favo = Mstr.anml.is_favo(prm._name, _s._cls, _s._name)

	if not is_favo then return end
	
	Emtn.cre(_s:pos() + t.vec(0, Map.sqh * 3 / 2))

	Ply_data.zu._zu.anml[prm._name] = _.t
	log.pp("Food.__presentd "..prm._name, Ply_data.zu._zu.anml)

	_s:del()
end

