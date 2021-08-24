log.scrpt("chara_clb_fe.lua")

Chara_clb_fe = {
	act_intrvl_time = 8,
	speed           = 2, -- 50,
	
	chara = {
		"aqua", "celica", "elise", "hinoka", "kamira", "kamui",
		"linda", "liz", "lucina", "minerva", "oboro", "olivie",
		"rian", "rin", "rufle", "sakura", "sallya", "sheeda",
		"tiamo", "tiki",
	},
	flyabl = {
		"hinoka", "kamira", "minerva", "sheeda", "tiamo",
	},
}
Chara_clb_fe.cls = "chara_clb_fe"
Chara_clb_fe.fac = Obj.fac..Chara_clb_fe.cls
Cls.add(Chara_clb_fe)
ha.add_6_ar(Chara_clb_fe.chara)

-- static

function Chara_clb_fe.cre(p_pos, p_name)
	
	if Map.chara_clb_fe_is_appear_all() then return end
	
	p_pos  = p_pos  or pos.pos_w()
	p_name = p_name or Chara_clb_fe.new_name()
	
	local prm = {}

	prm._name = p_name

	prm._is_flyabl = ar.in_(p_name, Chara_clb_fe.flyabl)
	
	local t_Cls = Chara_clb_fe
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	
	Map.add_chara_clb_fe(p_name)
	return t_id
end

function Chara_clb_fe.new_name(clb_grp)

	local not_appear_chara = Map.not_appear_chara_clb_fe(clb_grp)
	local new_name = ar.rnd(not_appear_chara)
	return new_name
end

-- scrpt method

function Chara_clb_fe.init(_s)

	extnd.init(_s, Chara_clb)
	extnd._(   _s, Chara_clb_fe)
end

-- method

