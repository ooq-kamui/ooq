log.scrpt("p.msg.lua")

p.Msg = {}

-- static

function p.Msg.cre(parent_gui)
	local p_Prt = p.Msg
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- scrpt method

function p.Msg.init(_s, parent_gui)
	-- log._("p msg init")

	_s._lb = "msg"
	_s._itm_pitch   = 75
	_s._dsp_idx_max =  5
	_s._itm_scrl_dir = "v"

	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_que)
	extnd._(   _s, p.Msg)

	-- timer
	local intrvl_time = 3
	local fnc = function (slf, hndl, elpsd)
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

	local itm_nd = p.Prt_itm_que.itm__add(_s, itm)
	
	local txt = itm
	local txt_len_max = 20
	local txt_len = string.len(txt)
	if txt_len > txt_len_max then
		txt = string.sub(txt, 1, txt_len_max - 2)..".."
	end
	
	nd.txt__(itm_nd[_s:lb("txt")], txt)

	_s:itm__plt_anm()
end

