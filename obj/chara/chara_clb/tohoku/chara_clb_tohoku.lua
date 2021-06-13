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
Cls.add(Chara_clb_tohoku)

ha.add_6_ar(Chara_clb_tohoku.chara)

-- static

function Chara_clb_tohoku.cre(p_pos, p_name)
	
	if Map.chara_clb_tohoku_is_appear_all() then return end
	
	p_pos  = p_pos  or pos.pos_w()
	p_name = p_name or Chara_clb_tohoku.new_name()
	
	local prm = {}

	prm._name = p_name

	prm._is_flyabl = ar.in_(p_name, Chara_clb_tohoku.flyabl)
	
	local t_Cls = Chara_clb_tohoku
	local t_id = Sp.cre(t_Cls, p_pos, prm)

	Map.add_chara_clb_tohoku(p_name)
	return t_id
end

function Chara_clb_tohoku.new_name(clb_grp)

	local not_appear_chara = Map.not_appear_chara_clb_tohoku(clb_grp)
	local new_name = ar.rnd(not_appear_chara)
	return new_name
end

-- script method

function Chara_clb_tohoku.init(_s)
	
	extnd.init(_s, Chara_clb)
	extnd._(   _s, Chara_clb_tohoku)
end

-- method

