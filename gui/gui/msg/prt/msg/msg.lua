log.script("p.msg.lua")

p.Msg = {}

-- static

function p.Msg.cre(parent_gui)
	local p_Prt = p.Msg
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Msg.init(_s, parent_gui)
	-- log._("p msg init")

	_s._lb = "msg"

	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm)
	extend.init(_s, p.Prt_itm_lst)
	extend._(_s, p.Msg)

	_s._itm_pitch   = 75
	_s._dsp_idx_max =  5

	-- timer
	local intrvl_time = 3
	local fnc = function (slf, hndl, elpsd)
		-- log._("timer.delay itm__del_1 #_s._itm", #_s._itm)
		_s:itm__del_1()
	end
	local hndl = timer.delay(intrvl_time, _.t, fnc)
	_s:parent_gui_hndl__add(hndl)
end

-- method

function p.Msg.opn(_s)
	
	_s:base_dsp__(_.t)
end

function p.Msg.clz(_s)
	
	_s._parent_gui:back()
end

function p.Msg.itm__add(_s, itm)
	-- log._("msg itm itm__add", itm)

	local itm_nd = p.Prt_itm.itm__add(_s, itm)
	
	local txt = itm
	local txt_len_max = 20
	local txt_len = string.len(txt)
	if txt_len > txt_len_max then
		txt = string.sub(txt, 1, txt_len_max - 2)..".."
	end
	-- log._("p.Msg.itm__add", txt)
	
	nd.txt__(itm_nd[_s:lb("txt")], txt)

	_s:itm__plt_anm()
end

function p.Msg.itm__plt_anm(_s)
	_s:itm__plt()
end

function p.Msg.base_pos__(_s, p_pos)
	-- log._("msg base_pos__", p_pos)

	p_pos = p_pos or Disp.center

	p.Prt_base.base_pos__(_s, p_pos)
end

function p.Msg.base_pos__d(_s)
	-- log._("msg base_pos__d")

	local t_pos = Disp.center + n.vec(0, -200)
	_s:base_pos__(t_pos)
end

