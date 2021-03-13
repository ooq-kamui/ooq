log.scrpt("grave.lua")

Grave = {
	act_intrvl_time = 10,
	name_idx_max = 1,
}
Grave.cls = "grave"
Grave.fac = "graveFac"
Grave.Fac = Obj.fac..Grave.cls
Cls.add(Grave)

-- static

function Grave.cre(p_pos, prm)
	local Cls = Grave
	prm = prm or {}
	prm.animHa = prm.animHa or ha._("stand")
	-- if not prm.animHa then prm.animHa = ha._("stand") end
	local id = Sp.cre(Cls, p_pos, prm)
	return id
end

-- script method

function Grave.init(_s)
	-- log._("grave init")
	
	extend.init(_s, Sp)
	extend._(_s, Grave)
end

function Grave.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Grave.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- dead
	if _s:per_trnsf(1 / 10 * 100, Phantom) then return end

	if _s:per_del(1 / 20 * 100) then return end
	
	
end

function Grave.on_msg(_s, msg_id, prm, sender)
end

function Grave.final(_s)
	Sp.final(_s)
end

