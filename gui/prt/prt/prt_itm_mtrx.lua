log.script("p.prt_itm_mtrx.lua")

p.Prt_itm_mtrx = {}

function p.Prt_itm_mtrx.init(_s)

	extend.init(_s, p.Prt_itm)
	extend._(_s, p.Prt_itm_mtrx)
	
	_s._itm_scrl_dir = "h"

	_s._xy_size = n.vec(6, 6) -- default

	_s._page_idx_max = 1 -- init
	_s._page_idx = 1

	_s._itm_pitch = {w = 50, h = 50}
end

-- page

function p.Prt_itm_mtrx.page_idx_max__(_s)
	
	_s._page_idx_max = page.page_idx_max(_s:itm_idx_max(), _s._dsp_idx_max)
end

function p.Prt_itm_mtrx.page__plt(_s)
	
	_s:itm__plt()
end

function p.Prt_itm_mtrx.page_mv(_s, dir)
	log._("prt itm mtrx page_mv", dir)

	_s:itm_dsp__x()
	_s:page_idx__mv(dir)
	_s:dsp1_itm_idx__()
	_s:page__plt()
end

function p.Prt_itm_mtrx.page_idx__mv(_s, dir)
	if     dir == "dec" then
		_s._page_idx = u.dec_loop(_s._page_idx, _s._page_idx_max)
	elseif dir == "inc" then
		_s._page_idx = u.inc_loop(_s._page_idx, _s._page_idx_max)
	end
	log._("itm mtrx page_idx__mv", _s._page_idx)
end

-- itm

function p.Prt_itm_mtrx.itm_pos_by_dsp_idx(_s, dsp_idx)
	-- log._("itm mtrx itm_pos_by_dsp_idx", dsp_idx)

	-- pos
	local t_xy = xy.idx_2_xy(dsp_idx, _s._xy_size)
	local pos  = xy._2_pos(t_xy, _s._xy_size, _s._itm_pitch)
	return pos
end

-- dsp 

function p.Prt_itm_mtrx.dsp_idx_max__(_s)
	
	_s._dsp_idx_max = _s._xy_size.x * _s._xy_size.y
end

function p.Prt_itm_mtrx.dsp1_itm_idx__(_s)

	_s._dsp1_itm_idx = page.dsp1_itm_idx(_s._page_idx, _s._dsp_idx_max)
end
