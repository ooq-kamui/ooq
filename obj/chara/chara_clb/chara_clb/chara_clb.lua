log.scrpt("chara_clb.lua")

Chara_clb = {

	act_intrvl_time = 8,
	speed           = 2, -- 50,
}

-- static

-- script method

Chara_clb.init       = Chara.init

Chara_clb.upd        = Chara.upd

Chara_clb.act_intrvl = Chara.act_intrvl

Chara_clb.on_msg     = Chara.on_msg

-- method

Chara_clb.anim__            = Chara.anim__

Chara_clb.act_intrvl__      = Chara.act_intrvl__

Chara_clb.act_intrvl_time__ = Chara.act_intrvl_time__

Chara_clb.say               = Chara.say

