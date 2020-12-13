log.script("p.bg.lua")

p.Bg = {
	bg_idx_max =  37,
	fade_o_time = 1,
	fade_i_time = 3,
	intrvl_time = 3,
}

-- static

function p.Bg.cre(parent_gui)
	local p_Prt = p.Bg
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Bg.init(_s, parent_gui)

	_s._lb = "bg"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm)
	extend._(_s, p.Bg)

	_s:nd__("img")
	nd.dsp__o(_s._nd.base)
	nd.dsp__x(_s._nd.img)
	
	_s:bg__rnd()
	
	-- timer
	local intrvl_time = p.Bg.fade_o_time + p.Bg.fade_i_time + p.Bg.intrvl_time
	local fnc = function (slf, hndl, elpsd)
		_s:bg__rnd()
	end
	local hndl = timer.delay(intrvl_time, _.t, fnc)
	_s:parent_gui_hndl__add(hndl)
end

function p.Bg.bg__(_s, p_anm)
	
	local w = nd.w(_s:nd("img"))
	local fade_o_time = (w == 0) and 0 or p.Bg.fade_o_time
	local fade_i_time = p.Bg.fade_i_time
	
	local anm = {}
	anm[1] = function ()
		-- nd.anm.fade_o(_s._nd.img, anm[2], fade_o_time)
		nd.anm.fade__o(_s:nd("img"), fade_o_time, anm[2])
	end
	anm[2] = function ()
		nd.txtr__(_s:nd("img"), p_anm)
		nd.anm__( _s:nd("img"), p_anm)
		-- nd.anm.fade_i(_s._nd.img,    nil, fade_i_time)
		nd.anm.fade__i(_s:nd("img"), fade_i_time)
	end
	anm[1]()
	-- log._("bg bg__", p_anm, w, fade_o_time, fade_i_time)
end

function p.Bg.bg__rnd(_s)
	local anm = _s._lb..rnd.int_pad(p.Bg.bg_idx_max)
	_s:bg__(anm)
end
