log.scrpt("p.dia.lua")

p.Dia = {}

-- static

function p.Dia.cre(parent_gui)
	local p_Prt = p.Dia
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Dia.init(_s, parent_gui)
	-- log._("dia init")

	_s._lb = "dia"

	extnd.init(_s, p.Prt, parent_gui)
	extnd._(_s, p.Dia)
	
	_s._itm_pitch = 100

	_s:nd__("chara")
	_s:nd__("txt")
	_s:nd__("arw")

	local t_pos = Disp.center + n.vec(0, 150)
	_s:base_pos__(t_pos)
end

-- method

function p.Dia.key_2_act_itm(_s, prm)
	-- log._("prt key_2_act_itm", prm.key, prm.keyact)

	local key    = prm.key
	local keyact = prm.keyact

	if     _s:is_key_arw(key, keyact) then
	elseif keyact == "p" then
		if     ar.inHa(key, {"x"}) then
			_s:decide()
		elseif ar.inHa(key, {"s"}) then
		elseif ar.inHa(key, {"z"}) then
		end
	end
end

function p.Dia.opn(_s, prm)
	-- log._("p.Dia.opn")
	
	pst._(".", "map_pause__", {val = _.t})

	pst.scrpt(Ev.id, "wa_inp")

	_s:txt__(D.txt[1])
	nd.anm.pyon_d_l(_s._nd.arw)
	
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")

	-- log._("p.Dia.opn msg_base_pos__d")
	pst._("#script", "msg_base_pos__d")
end

function p.Dia.clz(_s, se_off)
	-- log._("gp dia clz")

	pst._(".", "map_pause__", {val = _.f})

	pst.scrpt(Ev.id, "wa_inp_fin")
	
	if not se_off then Se.pst_ply("clz") end

	_s:base_dsp__(_.f)
	_s:focus__(_.f)

	_s._parent_gui:back()

	-- log._("p.dia.clz")
	pst._("#script", "msg_base_pos__")
end

function p.Dia.decide(_s)
	-- log._("dia decide()")
	_s:nxt()
end

function p.Dia.nxt(_s)
	-- log._("dia nxt")

	ar.del_1(D.txt)

	if #D.txt == 0 then _s:clz() return end

	_s:txt__(D.txt[1])
end

function p.Dia.chara__(_s, chara)
	nd.anm__(_s._nd.chara, chara.."-walk")
end

function p.Dia.txt__(_s, txt)
	nd.txt__(_s._nd.txt, txt)
end

