log.scrpt("p.prt.lua")

p = {}
p.Prt = {}

-- static

function p.Prt.cre(p_Prt, parent_gui)
	local prt = {}
	p_Prt.init(prt, parent_gui)
	return prt
end

-- scrpt method

function p.Prt.init(_s, parent_gui)
	-- log._("prt init", _s._lb)
	
	_s._parent_gui = parent_gui
	
	_s._nd = {}
	_s._nd.tpl = {}
	
	extnd.init(_s, p.Prt_base)
end

-- basic method

function p.Prt.behind(_s, fin)
	-- log._("gp logo behind")
	_s:base_dsp__(_.f, fin)
end

function p.Prt.clz(_s, se_off)

	if not se_off then Se.pst_ply("clz") end

	_s:base_dsp__(_.f)
	_s:focus__(_.f)

	_s._parent_gui:back()
end

function p.Prt.exe(_s)
	-- log._("prt exe")
	if not (type(_s._exe) == "function") then return end
	return _s._exe()
end

function p.Prt.exe__(_s, exe)
	_s._exe = exe
end

function p.Prt.lb(_s, nd_lb)
	local lb = _s._lb
	if nd_lb then lb = _s._lb.."/"..nd_lb end
	return lb
end

-- parent

function p.Prt.parent_gui_del(_s)

	if not _s._parent_gui then return end

	_s:focus__(_.f)
	_s._parent_gui:del()
end

function p.Prt.parent_gui_hndl__add(_s, hndl)
	ar.add(_s._parent_gui._hndl, hndl)
end

-- inp

function p.Prt.key_2_act(_s, prm)
	
	if not _s._focus then return end

	if     _s:is_inner_focus("itm")      then
		_s:key_2_act_itm(prm)

	elseif _s:is_inner_focus("itm_menu") then
		_s:key_2_act_itm_menu(prm)
	end
end

function p.Prt.key_2_act_itm(_s, prm)
	-- log._("prt key_2_act_itm", prm.key, prm.keyact)

	local key    = prm.key
	local keyact = prm.keyact

	if     _s:is_key_arw(key, keyact) then
		_s:arw_act(key, keyact)

	elseif keyact == "p" then
		if     ar.inHa(key, {"x"}) then
			_s:decide()
		elseif ar.inHa(key, {"s"}) then
			if _s._itm_menu then _s:itm_menu_opn()
			else                 _s:clz()
			end
		elseif ar.inHa(key, {"z"}) then
			_s:clz()
		end
	end

	-- log._("key_2_act_itm end")
end

-- arw -> cursor

function p.Prt.is_key_arw(_s, key, keyact)

	local ret

	if      ar.inHa(key, Inp.keys_arw)
	and not ar.in_(keyact, {"w", "f"}) then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

function p.Prt.arw_act(_s, arwHa, keyact)
	-- log._("prt arw_act", arwHa, keyact)
	
	-- if not _s.is_cursor__mv then return end -- necessary ?

	local is_cursor__mv, inc_dir = _s:is_cursor__mv(arwHa)
	-- log._("is_cursor__mv", is_cursor__mv)
	
	if is_cursor__mv then
		_s:cursor__mv(inc_dir, keyact)
	else
		_s:arw_act_othr(inc_dir, keyact)
	end
end

function p.Prt.arw_act_othr(_s, inc_dir, keyact)
	-- _s:cursor_itm_opt_ch(inc_dir)
end

function p.Prt.cursor_itm_opt_ch(_s, inc_dir)
	-- default
end

-- actv __

function p.Prt.actv__(_s, val)
	-- empty
end

function p.Prt.actv__o(_s)
	_s:actv__(_.t)
end

function p.Prt.actv__x(_s)
	-- log._("prt actv__x")
	_s:actv__(_.f)
end

-- focus

function p.Prt.focus__(_s, val)
	-- log._("p.Prt focus__", val)

	_s._focus = val
	
	local t_url = url.slf()
	if val then
		-- log._("p.Prt focus__t", val)
		pst._(".", "inp_focus__t", {focus_gui_url = t_url, focus_gui_lb = _s._lb})
	else
		-- log._("p.Prt focus__f", val)
		pst._(".", "inp_focus__f")
	end
end

-- inner focus

function p.Prt.inner_focus(_s)
	return _s._inner_focus
end

function p.Prt.inner_focus__(_s, inner_focus)

	inner_focus = inner_focus or "itm"

	_s._inner_focus = inner_focus
end

function p.Prt.is_inner_focus(_s, inner_focus)
	local ret = _.f
	if not _s._inner_focus then _s._inner_focus = "itm" end
	if _s._inner_focus == inner_focus then ret = _.t end
	return ret
end

-- confirm

function p.Prt.confirm(_s)
	local confirm = _s._parent_gui._confirm
	return confirm
end

function p.Prt.confirm_opn(_s)
	local called_6_prt = _s
	_s._parent_gui:confirm_opn(called_6_prt)
end

-- url
--[[
function p.Prt.url(_s)
	local t_url = url.slf()
	return t_url
end
--]]

-- nd

function p.Prt.nd(_s, nd_lb)

	if _s._nd[nd_lb] then return _s._nd[nd_lb] end

	_s:nd__(nd_lb)
	return _s._nd[nd_lb]
end

function p.Prt.nd__(_s, nd_lb)
	_s._nd[nd_lb] = nd._(_s:lb(nd_lb))
end

function p.Prt.nd_pos(_s, nd_lb)
	local pos = nd.pos(_s._nd[nd_lb])
	return pos
end

function p.Prt.nd_dsp__o(_s, nd_lb, fin, time)
	_s:nd_dsp__(nd_lb, _.t, fin, time)
end

function p.Prt.nd_dsp__x(_s, nd_lb, fin, time)
	_s:nd_dsp__(nd_lb, _.f, fin, time)
end

function p.Prt.nd_dsp__(_s, nd_lb, val, fin, time)

	time = time or (val and 0.4 or 0.2)

	if not _s._nd[nd_lb] then log._("nd_dsp__ nd is nil", nd_lb) return end

	nd.anm.dsp__(_s._nd[nd_lb], val, time, fin)
end

function p.Prt.nd_dsp_0s__(_s, nd_lb, val)

	if not _s._nd[nd_lb] then log._("prt nd_dsp_0s node is nil", nd_lb) return end
	
	nd.dsp__(_s._nd[nd_lb], val)
end
