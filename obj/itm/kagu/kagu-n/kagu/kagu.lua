log.scrpt("kagu.lua")

Kagu = {
	act_intrvl_time =  10,
	name_idx_max    = 104,
	z = 0.1,

	weight = 2,
}
Kagu.cls = "kagu"
Kagu.fac = Obj.fac..Kagu.cls
Cls.add(Kagu)

-- static

function Kagu.cre(p_pos, prm)
	local t_Cls = Kagu
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Kagu.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Kagu)
end

function Kagu.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Kagu.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Kagu.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end


end

function Kagu.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Kagu.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

