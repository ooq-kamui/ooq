log.scrpt("grave.lua")

Grave = {
	act_intrvl_time = 10,
	name_idx_max = 1,
}
Grave.cls = "grave"
Grave.fac = Obj.fac..Grave.cls
Cls.add(Grave)

-- static

function Grave.cre(p_pos, prm)

	local t_Cls = Grave

	prm = prm or {}

	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- scrpt method

function Grave.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Grave)
end

function Grave.__init(_s, prm)
	
	prm._anim = prm._anim or "stand"

	Sp.__init(_s, prm)

	_s:upd__o()
end

function Grave.upd(_s, dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Grave.act_intrvl(_s, dt)

	-- dead
	if _s:per_trnsf(1 / 10 * 100, Phntm) then return end

	if _s:per_del(1 / 20 * 100) then return end
	
	
end

function Grave.on_msg(_s, msg_id, prm, sndr_url)

	Sp.on_msg(_s, msg_id, prm, sndr_url)
end

function Grave.final(_s)

	Sp.final(_s)
end

