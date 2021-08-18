log.scrpt("bush.lua")

Bush = {
	act_intrvl_time = 15,
	name_idx_max = 100,
	foot_dst_i = 40,
	z = 0.04,
}
Bush.cls = "bush"
Bush.fac = Obj.fac..Bush.cls
Cls.add(Bush)

-- static

function Bush.cre(p_pos, prm)
	local t_Cls = Bush
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Bush.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Bush)
end

function Bush.__init(_s, prm)

	Sp.__init(_s, prm)
end

function Bush.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Bush.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1 / 10 * 100) then return end

	dice100.throw()
	if     dice100.chk(15) then
		-- empty -- _s:trnsf(Tree)
	end
end

function Bush.on_msg(_s, msg_id, prm, sndr_url)

	Sp.on_msg(_s, msg_id, prm, sndr_url)
end

function Bush.final(_s)

	Sp.final(_s)
end

