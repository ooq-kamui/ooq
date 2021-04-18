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
	
end

-- script method

function Chara_clb_fe.init(_s, dt)
	
	extend.init(_s, Chara_clb)
	extend._(   _s, Chara_clb_fe)
end

-- method

