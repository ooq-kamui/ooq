log.scrpt("chara_clb.lua")

Chara_clb = {

	act_intrvl_time = 8,
	speed           = 2, -- 50,
}

-- static

-- scrpt method

-- Chara_clb.init       = Chara.init

function Chara_clb.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Livingmove)
	extnd._(_s, Chara)
end

Chara_clb.upd        = Chara.upd

-- Chara_clb.__init     = Chara.__init

--[[

Chara_clb.act_intrvl = Chara.act_intrvl

Chara_clb.on_msg     = Chara.on_msg

-- method

Chara_clb.anim__            = Chara.anim__

Chara_clb.act_intrvl__      = Chara.act_intrvl__

Chara_clb.act_intrvl_time__ = Chara.act_intrvl_time__

Chara_clb.say               = Chara.say
--]]

