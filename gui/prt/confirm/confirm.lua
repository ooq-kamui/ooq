log.script("p.confirm.lua")

p.Confirm = {}

-- static

function p.Confirm.cre(parent_gui)
	local p_Prt = p.Confirm
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Confirm.init(_s, parent_gui)

	_s._lb = "confirm"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Confirm)

	_s._itm_pitch = 240
	_s._itm_scrl_dir = "h"
	_s._dsp_idx_max = 2
	_s._cursor_dsp_idx = 2

	_s:itm__by_ar({"cancel", "yes"})
	
	local node
	for idx, text in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("txt")], _s._itm[idx])
	end
end

-- method

function p.Confirm.opn(_s, prm)

	_s._called_by_prt = prm.called_by_prt
	
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
	anm[1] = function ()
		nd.anm.poyon(_s._nd.cursor, anm[2])
	end
	anm[2] = function ()
		if yes then
			_s:exe()
		else
			_s:clz()
		end
	end
	anm[1]()
end

function p.Confirm.exe(_s)
	_s:clz()
	_s._called_by_prt:exe()
end
