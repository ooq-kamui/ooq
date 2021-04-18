log.scrpt("chara_clb_tohoku.lua")

Chara_clb_tohoku = {
	act_intrvl_time = 8,
	speed           = 2, -- 50,
	
	chara = {
		"zunko", "kiritan",
		"itako", "metan", "sora", "usagi",
	},
	flyabl = {},
}

Chara_clb_tohoku.cls = "chara_clb_tohoku"
Chara_clb_tohoku.fac = Obj.fac..Chara_clb_tohoku.cls
Cls.add(Chara_clb_tohoku, Chara_clb_tohoku.chara)

ha.add_by_ar(Chara_clb_tohoku.chara)

-- static

function Chara_clb_tohoku.cre(p_pos, p_name)
	
end

-- script method

function Chara_clb_tohoku.init(_s, dt)
	
	extend.init(_s, Chara_clb)
	extend._(   _s, Chara_clb_tohoku)
end

-- method

