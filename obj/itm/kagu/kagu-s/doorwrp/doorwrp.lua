log.scrpt("doorwrp.lua")

Doorwrp = {
	act_intrvl_time = 60,
	name_idx_max = 1,
	z = 0.1,

	weight = 2,
}
Doorwrp.cls = "doorwrp"
Doorwrp.fac = Obj.fac..Doorwrp.cls
Cls.add(Doorwrp)

-- static

function Doorwrp.cre(p_pos, prm)
	local t_Cls = Doorwrp
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Doorwrp.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Doorwrp)
end

function Doorwrp.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Doorwrp.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Doorwrp.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Doorwrp.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if ha.eq(msg_id, "opn") then
		_s:opn()
	end
end

function Doorwrp.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Doorwrp.opn(_s)
	fac.cre("#fac_doorwrp_gui")
end

