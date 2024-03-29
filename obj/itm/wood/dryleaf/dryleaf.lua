log.scrpt("dryleaf.lua")

Dryleaf = {
	act_intrvl_time = 10,
	name_idx_max = 4,
}
Dryleaf.cls = "dryleaf"
Dryleaf.fac = Obj.fac..Dryleaf.cls
Cls.add(Dryleaf)

-- static

function Dryleaf.cre(p_pos)
	local t_Cls = Dryleaf
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- scrpt method

function Dryleaf.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Spwood)
	extnd._(_s, Dryleaf)
end

function Dryleaf.__init(_s, prm)
	
	Sp.__init(_s, prm)
	Hldabl.__init(_s)
	Spwood.__init(_s)

	_s:upd__o()
end

function Dryleaf.upd(_s, dt)

	_s:upd_pos_sttc()

	_s:upd_final()
end

function Dryleaf.act_intrvl(_s, dt)

	_s:per_trnsf__humus(1 / 30 * 100)

end

function Dryleaf.final(_s)

	Sp.final(_s)
end

