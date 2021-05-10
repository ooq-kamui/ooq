log.scrpt("tree.lua")

Tree = {

	-- act_intrvl_time =  60,
	act_intrvl_time =  20,
	name_idx_max    = 100,

	z = 0.05,

	cre_prm = {
		"_bear_cls",
		"_bear_name",
	},
}
Tree.cls = "tree"
Tree.fac = Obj.fac..Tree.cls
Cls.add(Tree)

-- static

function Tree.cre(p_pos, prm, p_scl)
	local t_Cls = Tree
	local t_id = Sp.cre(t_Cls, p_pos, prm, p_scl)
	return t_id
end

-- script method

function Tree.init(_s)

	extend._(_s, Sp)
	extend._(_s, Tree)
end

function Tree.__init(_s, prm)
	
	Sp.__init(_s, prm)

	_s:bear__init()

	-- scale
	local size  = 1.5
	local t_url = url._(_s._id, "sprite")
	local scale = go.get(t_url, "scale")
	go.set(t_url, "scale", scale * size)

	_s._bear = {}
end

function Tree.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Tree.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp.on_msg(_s, msg_id, prm, sndr_url)
	
	if     ha.eq(msg_id, "trnsf_wood") then
		_s:trnsf_wood()
		
	elseif ha.eq(msg_id, "bear__x"   ) then
		_s:bear__x(prm.bear_id)
	end
end

function Tree.final(_s)
	
	Sp.final(_s)
	
	for idx, bear_id in pairs(_s._bear) do
		pst.scrpt(bear_id, "bear__x")
	end
end

-- method

function Tree.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	dice100.throw()
	if     dice100.chk(30) then
		_s:bear()

	elseif dice100.chk( 1) then
		Leaf.cre()

	elseif dice100.chk( 1) then
		_s:trnsf(Wood)
	end
end

function Tree.bear(_s)
	
	if #_s._bear >= 1 then return end
	
	if not _s._bear_cls then _s:bear__init() end

	local bear_Cls = Cls.Cls(_s._bear_cls)
	
	if not _s._bear_name then
		_s._bear_name = bear_Cls.cls..rnd.int_pad(bear_Cls.name_idx_max)
	end
	
	local t_pos = _s:pos_w() + n.vec(0, Map.sqh)
	-- log._("bear fruit cre")

	local t_id = bear_Cls.cre(t_pos, {_name = _s._bear_name}, 0.2)
	pst.scrpt(t_id, "bear__o", {tree_id = _s._id})
	ar.add(_s._bear, t_id)
end

function Tree.bear__x(_s, bear_id)
	ar.del_by_val(_s._bear, bear_id)
end

function Tree.trnsf_wood(_s, num)

	num = num or 3
	local t_pos, x
	for i = 1, num do
		x = u.x_by_all_w(i, num, Map.sq)
		t_pos = _s:pos() + n.vec(x, Map.sqh)
		Wood.cre(t_pos)
	end
	Se.pst_ply("tree_break")
	
	_s:del()
end

function Tree.bear__init(_s)

	_s._bear_cls  = _s._bear_cls  or "fruit"
	_s._bear_name = _s._bear_name or "fruit007"

	log._("Tree.bear__init", _s._bear_cls, _s._bear_name)
end

function Tree.pb__save_data(_s, map_url)

	local prm = {}

	prm._cls  = _s._cls
	prm._name = _s._name
	prm._pos  = _s:pos()

	prm._bear_cls  = _s._bear_cls
	prm._bear_name = _s._bear_name

	pst._(map_url, "save_data_obj__", prm)
end

