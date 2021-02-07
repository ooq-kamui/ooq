log.scrpt("p.prt_itm_menu.lua")

p.Prt_itm_menu = {}

function p.Prt_itm_menu.init(_s)
	
end

-- method

function p.Prt_itm_menu.key_2_act_itm_menu(_s, prm)

	local key    = prm.key
	local keyact = prm.keyact

	if     _s:is_key_arw(key, keyact) then
		prm.dir = Inp.gui.arwHa_2_inp_dir[key]
		_s:itm_menu_arw_act(prm)

	elseif keyact == "p" then
		if     ar.inHa(key, {"x"}) then
			_s:itm_menu_decide()

		elseif ar.inHa(key, {"s", "z"}) then
			_s:itm_menu_clz()
		end
	end
end

function p.Prt_itm_menu.itm_menu(_s)
	local itm_menu = _s._itm_menu
	return itm_menu
end

-- fr ply_slt

function p.Prt_itm_menu.nd_itm_menu__(_s)

	_s._nd.tpl.itm_menu = nd._(_s:lb("itm_menu"))

	_s._nd.itm_menu = {}
	for idx, txt in pairs(_s._itm_menu) do
		local itm_menu = nd.clone(_s._nd.tpl.itm_menu)
		nd.txt__(itm_menu[_s:lb("itm_menu_txt")], txt)
		ar.add(_s._nd.itm_menu, itm_menu)
	end
	_s._nd.itm_menu_cursor = nd._(_s:lb("itm_menu_cursor"))
	_s._nd.itm_menu_icn    = nd._(_s:lb("itm_menu_icn"))

	nd.enbl__(_s._nd.tpl.itm_menu, _.f)
end

function p.Prt_itm_menu.itm_menu_opn(_s)

	if not _s:cursor_itm() then
		Se.pst_ply("back")
		return 
	end

	_s:itm_menu_actv__o()
	Se.pst_ply("forward")
end

function p.Prt_itm_menu.itm_menu_clz(_s)
	_s:itm_menu_actv__x()
	_s:itm_menu_icn_dsp__auto()
	Se.pst_ply("back")
end

function p.Prt_itm_menu.itm_menu_actv__o(_s)
	_s:inner_focus__("itm_menu")
	_s:itm_menu_icn_dsp__(_.f)
	_s:itm_menu_dsp__(_.t)
end

function p.Prt_itm_menu.itm_menu_actv__x(_s)
	_s:inner_focus__("itm")
	_s:itm_menu_dsp__(_.f)
	_s:itm_menu_icn_dsp__(_.t)
end

function p.Prt_itm_menu.itm_menu_icn_dsp__(_s, val)
	
	local time = 0.35
	if not val then time = 0.01 end
	nd.anm.dsp__(_s._nd.itm_menu_icn, val, time)
end

function p.Prt_itm_menu.itm_menu_icn_dsp__auto(_s)
	if _s:cursor_itm() then
		_s:itm_menu_icn_dsp__(_.t)
	else
		_s:itm_menu_icn_dsp__(_.f)
	end
end

function p.Prt_itm_menu.itm_menu_dsp__(_s, val)

	local pos = nd.pos(_s._nd.tpl.itm_menu)

	local dy = 30
	local itm_menu_pos
	for idx, itm_menu in pairs(_s._nd.itm_menu) do
		-- log._("itm_menu_dsp__", val)
		itm_menu_pos = pos + n.vec(0, -dy * (idx - 1))
		nd.pos__(itm_menu[_s:lb("itm_menu")], itm_menu_pos)
		nd.anm.dsp__(itm_menu[_s:lb("itm_menu")], val)
	end

	nd.pos__(_s._nd.itm_menu_cursor, pos)
	nd.anm.dsp__(_s._nd.itm_menu_cursor, val)
end

function p.Prt_itm_menu.itm_menu_arw_act(_s, prm)
	_s:itm_menu_cursor_mv(prm)
end

function p.Prt_itm_menu.itm_menu_cursor_mv(_s, prm)
	log._("itm_menu_cursor_mv()")
end

function p.Prt_itm_menu.itm_menu_decide(_s)
	-- log._("itm_menu_decide()")

	Se.pst_ply("forward")

	_s:behind()
	_s:exe__(function () _s:itm_menu_exe() end)
	_s:confirm_opn()
end

function p.Prt_itm_menu.itm_menu_exe(_s) -- refactoring
	-- log._("itm_menu_exe()")

	local ply_slt_idx = _s:cursor_itm_idx()
	_s:clr(ply_slt_idx)

	-- redrw
	_s:itm__load(ply_slt_idx)
	_s:nd_itm_txt__(ply_slt_idx)

	_s:itm_menu_clz()
end
