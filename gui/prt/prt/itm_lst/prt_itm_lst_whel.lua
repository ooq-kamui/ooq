log.scrpt("p.prt_itm_lst_whel.lua")

-- whel

-- whel __ init

function p.Prt_itm_lst.whel__init(_s)

	if not _s._whel then
		_s._whel   = {}
		_s._nd.itm = {}
	else
		ar.clr(_s._whel  )
		ar.clr(_s._nd.itm)
	end

	if not _s._itm   then return end
	if #_s._itm == 0 then return end

	for whel_idx = 1, _s:whel_idx_max() do
		_s:whel_i__init(whel_idx)
	end

	-- _s:whel_nd__init()
end

function p.Prt_itm_lst.whel_i__init(_s, whel_idx)

	local itm_idx = whel_idx

	if not _s._itm[itm_idx] then return end

	_s._whel[whel_idx] = itm_idx

	nd_itm_ar = _s:whel_i_nd__cln()
	ar.add(_s._nd.itm, nd_itm_ar)

	_s:whel_i_nd__(whel_idx, itm_idx)
end

-- whel __ plt

function p.Prt_itm_lst.whel__plt_anm(_s, dsp1_itm_idx)

	return _s:whel__plt(dsp1_itm_idx)
end

function p.Prt_itm_lst.whel__plt(_s, dsp1_itm_idx)

	local dsp_idx

	if dsp1_itm_idx then
		dsp_idx = _s:dsp1_itm_idx__(dsp1_itm_idx)
	end

	for whel_idx, itm_idx in pairs(_s._whel) do

		_s:whel_i__plt(whel_idx)
	end

	return dsp_idx
end

-- whel utl

function p.Prt_itm_lst.whel_idx_max(_s)

	return _s._dsp_idx_max + 2
end

function p.Prt_itm_lst.itm_idx_6_whel_idx(_s, whel_idx)

	local itm_idx = _s._whel[whel_idx]
	-- log.p("p.Prt_itm_lst.itm_idx_6_whel_idx", _s._whel)
	-- log._("p.Prt_itm_lst.itm_idx_6_whel_idx", itm_idx, whel_idx)

	return itm_idx
end

--[[
dsp whel
       3

  1    4
  2    5
  3    6
  4    7
  5    1
 
       2
--]]
function p.Prt_itm_lst.dsp_idx_6_whel_idx(_s, whel_idx)

	local dsp_idx

	dsp_idx = whel_idx - _s._dsp1_whel_idx + 1

	if dsp_idx <= 0 then
		dsp_idx = dsp_idx + _s:whel_idx_max()
	end
	if dsp_idx > _s._dsp_idx_max then
		dsp_idx = nil
	end

	-- log._("p.Prt_itm_lst.dsp_idx_6_whel_idx", whel_idx, dsp_idx, _s._dsp1_whel_idx)
	return dsp_idx
end

function p.Prt_itm_lst.whel_idx_6_itm_idx(itm_idx)

	local page_idx, whel_idx = int.dlm(itm_idx, _s._dsp_idx_max)

	return whel_idx, page_idx
end

-- whel w

function p.Prt_itm_lst.whel_w__o(_s)

	_s:whel_w__(_.t)
end

function p.Prt_itm_lst.whel_w__x(_s)

	_s:whel_w__(_.f)
end

function p.Prt_itm_lst.whel_w__(_s, val)
	
	for whel_idx, itm_idx in pairs(_s._whel) do
		_s:whel_i_w__(whel_idx, val)
	end
end

-- whel nd

--[[
function p.Prt_itm_lst.whel_nd__init(_s)

	_s._nd.itm = {}

	local nd_itm_ar

	for itm_whel_idx, itm_idx in pairs(_s._whel) do

		nd_itm_ar = _s:whel_i_nd__cln()
		ar.add(_s._nd.itm, nd_itm_ar)
	end
end
--]]

-- whel i

-- whel i __ plt

function p.Prt_itm_lst.whel_i__plt_anm(_s, whel_idx)
	
	if _s:is_whel_i_dsp(whel_idx) then
		
		_s:whel_i_pos__anm(whel_idx)
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.t)
	else
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.f)
		_s:whel_i_pos__tpl(whel_idx)
	end
end

function p.Prt_itm_lst.whel_i__plt(_s, whel_idx)
	
	if _s:is_whel_i_dsp(whel_idx) then
		
		_s:whel_i_pos__(whel_idx)
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.t)
	else
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.f)
		_s:whel_i_pos__tpl(whel_idx)
	end
end

function p.Prt_itm_lst.whel_i_pos__anm(_s, whel_idx)

	local dsp_idx = _s:dsp_idx_6_whel_idx(whel_idx)
	local t_pos   = _s:dsp_pos(dsp_idx)

	local time = 0.7
	nd.anm.mv(_s:whel_i_nd_itm(whel_idx), t_pos, nil, time)
end

function p.Prt_itm_lst.whel_i_pos__(_s, whel_idx)

	local dsp_idx = _s:dsp_idx_6_whel_idx(whel_idx)
	local t_pos   = _s:dsp_pos(dsp_idx)

	nd.pos__(_s:whel_i_nd_itm(whel_idx), t_pos)
end

function p.Prt_itm_lst.whel_i_pos__tpl(_s, whel_idx)

	nd.pos__(_s:whel_i_nd_itm(whel_idx), _s._tpl_itm_pos)
end

-- whel i w

function p.Prt_itm_lst.whel_i_w__(_s, whel_idx, val)

	nd.dsp__(_s:whel_i_nd_itm(whel_idx), val)
end

-- whel i nd

-- whel i nd __ init

function p.Prt_itm_lst.whel_i_nd__cln(_s)
	
	local nd_itm_ar = nd.cln(_s._nd.tpl.itm)

	nd.ar.enbl__(nd_itm_ar, _.t)

	return nd_itm_ar
end

-- whel i nd basic

function p.Prt_itm_lst.whel_i_nd_ar(_s, whel_idx)

	local itm_nd_ar = _s._nd.itm[whel_idx]
	return itm_nd_ar
end

function p.Prt_itm_lst.whel_i_nd_itm(_s, whel_idx)

	local itm_nd = _s._nd.itm[whel_idx][_s:lb("itm")]
	return itm_nd
end

