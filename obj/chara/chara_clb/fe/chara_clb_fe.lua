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
Cls.add(Chara_clb_fe, Chara_clb_fe.chara) -- ??

ha.add_by_ar(Chara_clb_fe.chara) -- ??

-- static

function Chara_clb_fe.cre(p_pos, p_name)
	
	if Map.chara_clb_fe_is_appear_all() then return end
	
	p_pos  = p_pos  or pos.pos_w()
	p_name = p_name or Chara_clb_fe.new_name()
	
	local prm = {}
	prm.clsHa  = ha._(Chara_clb_fe.cls)
	prm.nameHa = ha._(p_name)

	prm.is_fly = Chara_clb_fe.is_flyabl(p_name) -- to init
	
	local map_id, game_id = Game.map_id()
	if ha.is_emp(map_id) then return end
	
	prm.game_id   = game_id
	prm.map_id    = map_id
	prm.parent_id = map_id
	-- prm.z = Chara_clb_fe.z

	-- log.pp("Chara_clb_fe cre prm", prm)
	ar.key___(prm)
	local t_id = fac.cre("/obj-fac/"..Chara_clb_fe.fac, p_pos, nil, prm)
	
	Map.add_chara_clb_fe(p_name)
	return t_id
end

function Chara_clb_fe.is_flyabl(chara)

	local ret = ar.in_(chara, Chara_clb_fe.flyabl)
	return ret
end

function Chara_clb_fe.new_name(clb_grp)

	local not_appear_chara = Map.not_appear_chara_clb_fe(clb_grp)
	local new_name = ar.rnd(not_appear_chara)
	return new_name
end

-- script method

function Chara_clb_fe.init(_s, dt)
	
	extend.init(_s, Chara_clb)
	extend._(   _s, Chara_clb_fe)
end

-- method

