log.scrpt("reizoko.lua")

Reizoko = {

	act_intrvl_time = 20,
	name_idx_max    =  1,
	z = 0.1,

	weight = 2,
}
Reizoko.cls = "reizoko"
Reizoko.fac = Obj.fac..Reizoko.cls
Cls.add(Reizoko)

-- static

function Reizoko.cre(p_pos)
	local t_Cls = Reizoko
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Reizoko.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Reizoko)
end

function Reizoko.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Reizoko.upd(_s, dt)

	_s:upd_pos_static(dt)

	_s:act_intrvl(dt)

	_s:upd_final()
end

function Reizoko.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end


end

function Reizoko.on_msg(_s, msg_id, prm, sndr_url)
	
	local st

	st = Sp.on_msg(_s, msg_id, prm, sndr_url)
	if st then return end

	Hldabl.on_msg(_s, msg_id, prm, sndr_url)

	if     ha.eq(msg_id, "opn") then
		_s:opn()
		
	elseif ha.eq(msg_id, "clz") then
		_s:clz()
		
	elseif ha.eq(msg_id, "into_reizoko") then
		_s:into_reizoko(prm.food_id)
	end
end

function Reizoko.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Reizoko.opn(_s)
	fac.cre("#fac_reizoko_gui")
end

function Reizoko.into_reizoko(_s, food_id)

	pst.scrpt(food_id, "__into_reizoko")
end

