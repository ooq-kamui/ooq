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

-- scrpt method

function Doorwrp.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Doorwrp)
end

function Doorwrp.__init(_s, prm)
	
	if not prm._anim then prm._anim = "stand" end

	Sp.__init(_s, prm)
	Hldabl.__init(_s)

	_s:upd__o()
end

function Doorwrp.upd(_s, dt)

	_s:upd_pos_sttc()

	_s:upd_final()
end

function Doorwrp.act_intrvl(_s, dt)

end

function Doorwrp.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if     ha.eq(msg_id, "opn"         ) then
		_s:opn()

	elseif ha.eq(msg_id, "anim__opnclz") then
		_s:anim__opnclz()

	elseif ha.eq(msg_id, "animation_done") then

		if ha.eq(prm.id, _s._name.."-opnclz") then
			_s:anim__("stand")
		end
	end
end

function Doorwrp.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Doorwrp.opn(_s)

	local prm = {
		doorwrp_id     = _s._id,
		doorwrp_gui_id = fac.cre("#fac_doorwrp_gui"),
	}
	pst.scrpt(_s:map_id(), "gui:doorwrp:opn", prm)

	-- _s:anim__("opn")
end

function Doorwrp.anim__(_s, p_anim)

	p_anim = p_anim or "stand"

	local t_anim = _s._name.."-"..p_anim
	Sp.anim__(_s, t_anim)
end

function Doorwrp.anim__opnclz(_s)

	_s:anim__("opnclz")
end

