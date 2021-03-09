log.scrpt("tree.lua")

Tree = {
	act_intrvl_time = 5,
	name_idx_max = 100,

	z = 0.05,
}
Tree.cls = "tree"
Tree.fac = Tree.cls.."Fac"
Tree.Fac = Obj.fac..Tree.cls
Cls.add(Tree)

-- static

function Tree.cre(pos, prm, scl)
	local Cls = Tree
	local id = Sp.cre(Cls, pos, prm, scl)
	return id
end

-- script method

function Tree.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Tree)

	-- scale
	local size = 1.5
	local t_url = url._(_s._id, "sprite")
	local scale = go.get(t_url, "scale")
	go.set(t_url, "scale", scale * size)

	-- log._("tree init", _s._nameHa, _s._bear_cls, _s._bear_name)
	_s._bear = {}
end

function Tree.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Tree.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	dice100.throw()
	if     dice100.chk(1) then
		_s:trnsf(Wood)

	elseif dice100.chk(1) then
		Leaf.cre()

	elseif dice100.chk(5) then
		_s:bear()
	end
end

function Tree.on_msg(_s, msg_id, prm, sender)
	
	Sp.on_msg(_s, msg_id, prm, sender)
	
	if     ha.eq(msg_id, "trnsf_wood") then
		_s:trnsf_wood()
		
	elseif ha.eq(msg_id, "bear_x") then
		_s:bear_x(prm.bear_id)
	end
end

function Tree.final(_s)
	
	Sp.final(_s)
	
	for idx, bear_id in pairs(_s._bear) do
		pst.scrpt(bear_id, "bear_x")
	end
end

-- method

function Tree.bear(_s)
	
	if #_s._bear >= 1 then return end
	
	if ha.is_emp(_s._bear_cls) then
		_s._bear_cls = ha._("fruit")
		_s._bear_name = nil
	end
	local bear_Cls = Cls._(_s._bear_cls)
	
	if ha.is_emp(_s._bear_name) then
		_s._bear_name = ha._(bear_Cls.cls..rnd.int_pad(bear_Cls.name_idx_max))
	end
	
	local pos = _s:wpos() + n.vec(0, Map.sqh)
	-- log._("bear fruit cre")
	local id = bear_Cls.cre(pos, {name = _s._bear_name}, 0.2)
	pst.scrpt(id, "bear_o", {tree_id = _s._id})
	ar.add(_s._bear, id)
end

function Tree.bear_x(_s, bear_id)
	ar.del_by_val(bear_id, _s._bear)
end

function Tree.trnsf_wood(_s, num)

	num = num or 3
	local pos, x
	for i = 1, num do
		x = u.x_by_all_w(i, num, Map.sq)
		pos = _s:pos() + n.vec(x, Map.sqh)
		Wood.cre(pos)
	end
	Se.pst_ply("tree_break")
	
	_s:del()
end
