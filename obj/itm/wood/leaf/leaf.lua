log.scrpt("leafFac.script")

Leaf = {
	act_intrvl_time = 10,
	name_idx_max = 4,

}
Leaf.cls = "leaf"
Leaf.fac = Obj.fac..Leaf.cls
Cls.add(Leaf)

function Leaf.cre(p_pos)
	local t_Cls = Leaf
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Leaf.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Spwood)
	extnd._(_s, Leaf)
end

function Leaf.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
	Spwood.__init(_s)
end

function Leaf.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Leaf.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1 / 20 * 100) then return end
	
	if _s:per_trnsf(1 / 20 * 100, Dryleaf) then return end
end

function Leaf.final(_s)

	Sp.final(_s)
end

