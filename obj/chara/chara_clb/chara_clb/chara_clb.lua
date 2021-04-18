log.scrpt("chara_clb.lua")

Chara_clb = {

	act_intrvl_time = 8,
	speed           = 2, -- 50,
}

-- static

function Chara_clb.new_name(clb_grp)

	local not_appear_chara = Map.not_appear_chara(clb_grp)
	local new_name = ar.rnd(not_appear_chara)
	return new_name
end

-- script method

Chara_clb.init       = Chara.init

Chara_clb.upd        = Chara.upd

Chara_clb.act_intrvl = Chara.act_intrvl

Chara_clb.on_msg     = Chara.on_msg

-- method

