log.scrpt("doorwrp.lua")

Doorwrp = {
	act_intrvl_time = 60,
	name_idx_max    =  1,
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
	
	if not prm._anim then prm._anim = "stand" end

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

	local t_id = fac.cre("#fac_doorwrp_gui")
	pst.gui(t_id, "gui:prp__", {_slfobj_id = _s._id})

	-- _s:anim__("opn")
end

function Doorwrp.anim__(_s, p_anim)

	p_anim = p_anim or "stand"

	local t_anim = _s._name.."-"..p_anim
	Sp.anim__(_s, t_anim)
end

