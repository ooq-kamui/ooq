log.scrpt("p.confirm.lua")

p.Confirm = {

	itm = {"cancel", "yes"},
}

-- static

function p.Confirm.cre(parent_gui)
	local p_Prt = p.Confirm
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Confirm.init(_s, parent_gui)
	log._("p.Confirm.init")

	_s._lb = "confirm"
	_s._itm_pitch   = 240
	_s._dsp_idx_max =   2
	_s._itm_scrl_dir = "h"
	-- _s._cursor_dsp_idx = 2
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Confirm)

	-- _s:whel__init()

	_s:itm__init()
end

function p.Confirm.itm__init(_s)
	_s:itm__6_ar(p.Confirm.itm)
end

function p.Confirm.whel_i_nd__(_s, whel_idx, itm_idx)

	local itm_i_nd_ar = _s:whel_i_nd_ar(whel_idx)

	log._("p.Confirm.whel_i_nd__", itm_idx)
	_s:log("p.Confirm.whel_i_nd__")
	nd.txt__(itm_i_nd_ar[_s:lb("txt")], _s._itm[itm_idx])
end

-- method

function p.Confirm.opn(_s, prm)

	_s._called_6_prt = prm.called_6_prt
	
	_s._cursor_dsp_idx = 2
	_s:cursor_pos__()

	_s:itm__plt()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Confirm.decide(_s)

	_s._focus = _.f
	
	local yes = (_s:cursor_itm() == "yes")

	local anm = {}
	if yes then
		anm[1] = function ()
			Se.pst_ply("exe")
			nd.anm.poyon(_s._nd.cursor, anm[2])
		end
		anm[2] = function ()
			local se_off = _.t
			_s:clz(se_off)
			_s:exe()
		end

	else
		anm[1] = function ()
			nd.anm.poyon(_s._nd.cursor, anm[2])
		end
		anm[2] = function ()
			_s:clz()
		end
	end
	anm[1]()
end

function p.Confirm.exe(_s)

	_s._called_6_prt:exe()
end

