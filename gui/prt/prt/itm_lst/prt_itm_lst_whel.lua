log.scrpt("p.prt_itm_lst_whel.lua")

-- whel

-- whel __ init

function p.Prt_itm_lst.whel__init(_s)
	-- log._("whel__init")

	if not _s._dsp_idx_max then log._("whel__init:dsp_idx_max nil") return end

	if not _s._whel then
		_s._whel   = {}
		_s._nd.itm = {}
		_s._nd.whel = _s._nd.itm -- alias
	else
		ar.clr(_s._whel  )
		ar.clr(_s._nd.itm)
	end

	_s:whel_idx_max__()

	for whel_idx = 1, _s:whel_idx_max() do
		_s:whel_i_nd__cln(whel_idx)
	end

	-- log._("whel__init end")
end

function p.Prt_itm_lst.whel__(_s)
	-- log._("whel__ start")

	if not _s:dsp1_itm_idx()  then return end
	if not _s:dsp1_whel_idx() then return end

	for whel_idx = 1, _s:whel_idx_max() do

		_s:whel_i__(whel_idx)
	end
	-- log._("whel__ end")
end

-- whel __ plt

function p.Prt_itm_lst.whel__plt(_s)

	if not _s:dsp1_itm_idx()  then return end
	if not _s:dsp1_whel_idx() then return end

	for whel_idx = 1, _s:whel_idx_max() do

		_s:whel_i__plt(whel_idx)
	end
end

-- whel __ roll

function p.Prt_itm_lst.whel__roll(_s, inc_dir)

	-- _s:log("whel__roll start")

	if _s:is_dsp_itm_edge(inc_dir) then return end

	_s:dsp1_itm_idx__dir(inc_dir)

	_s:dsp__plt_anm()

	Se.pst_ply("cursor__mv")

	-- _s:log("whel__roll end")
end

--[[
function p.Prt_itm_lst.dsp1o_nd__(_s) -- use not ?

	if _s:is_dsp_itm_1() then return end

	local dsp1o_itm_idx  = _s:dsp1o_itm_idx()
	local dsp1o_whel_idx = _s:dsp1o_whel_idx()

	log._("whel_nd__roll_dec", dsp1o_whel_idx, dsp1o_itm_idx)

	_s:whel_i_nd__(dsp1o_whel_idx, dsp1o_itm_idx)
end

function p.Prt_itm_lst.dspEo_nd__(_s) -- use not ?

	if _s:is_dsp_itm_E() then return end

	local dspEo_itm_idx  = _s:dspEo_itm_idx()
	local dspEo_whel_idx = _s:dspEo_whel_idx()

	log._("dspEo_nd__", dspEo_whel_idx, dspEo_itm_idx)

	_s:whel_i_nd__(dspEo_whel_idx, dspEo_itm_idx)
end

--]]

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

-- whel i

-- whel i __ plt

function p.Prt_itm_lst.whel_i__plt_anm(_s, whel_idx)
	
	if not whel_idx then return end

	if _s:is_whel_i_dsp(whel_idx) then
		
		_s:whel_i_pos__anm(whel_idx)
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.t)
	else
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.f)
		_s:whel_i_pos__tpl(whel_idx)
	end
end

function p.Prt_itm_lst.whel_i__plt(_s, whel_idx)
	-- log._("whel_i__plt start", whel_idx)

	if not whel_idx then return end
	
	if _s:is_whel_i_dsp(whel_idx) then
		-- log._("whel_i__plt t")
		
		_s:whel_i_pos__(whel_idx)
		nd.enbl__(_s:whel_i_nd_itm(whel_idx), _.t)
	else
		-- log._("whel_i__plt f")

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

-- whel i

function p.Prt_itm_lst.whel_i(_s, whel_idx)

	return _s._whel[whel_idx]
end

function p.Prt_itm_lst.whel_i__(_s, whel_idx)

	if not _s:dsp1_itm_idx()  then return end
	if not _s:dsp1_whel_idx() then return end

	local itm_idx = _s:itm_idx_6_whel_idx(whel_idx)

	_s._whel[whel_idx] = itm_idx

	if not itm_idx then

		return
	end

	_s:whel_i_nd__(whel_idx, itm_idx)
end

function p.Prt_itm_lst.is_whel_i_dsp(_s, whel_idx)

	local ret = _.f

	if not whel_idx then return ret end

	local itm_idx = _s:whel_i(whel_idx)

	if not itm_idx then return ret end

	if int.is_rng(itm_idx, _s:dsp_itm_rng()) then
		ret = _.t
	end

	-- log._("is_whel_i_dsp", whel_idx, ret)
	return ret
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

	ar.add(_s._nd.itm, nd_itm_ar)

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

-- whel utl

function p.Prt_itm_lst.whel_idx_max(_s)

	if _s._whel_idx_max then return _s._whel_idx_max end

	_s:whel_idx_max__()

	return _s._whel_idx_max
end

function p.Prt_itm_lst.whel_idx_max__(_s)

	if not _s._dsp_idx_max then return end

	local val = _s._dsp_idx_max + 2
	-- local val = _s:dspE_idx() + 2

	_s._whel_idx_max = val
end

function p.Prt_itm_lst.whel_idx_6_itm_idx(_s, itm_idx)

	local sct_idx, whel_idx = int.dlm(itm_idx, _s:whel_idx_max())

	return whel_idx, sct_idx
end

function p.Prt_itm_lst.whel_idx_6_dsp_idx(_s, dsp_idx)
	-- log._("whel_idx_6_dsp_idx start", dsp_idx, _s._dsp1_itm_idx, _s._dsp1_whel_idx)

	if not _s:dsp1_itm_idx()  then return end
	if not _s:dsp1_whel_idx() then return end

	local dsp_df = dsp_idx - 1
	local whel_idx = int.__pls_loop(_s:dsp1_whel_idx(), dsp_df, _s:whel_idx_max())

	-- log._("whel_idx_6_dsp_idx end", whel_idx, dsp_df)

	return whel_idx
end

-- whel log

function p.Prt_itm_lst.log(_s, txt)
	log._("=", txt)
	-- log._("itm_idx_max"      , _s:itm_idx_max()     )
	-- log._("dsp_idx_max"      , _s:dsp_idx_max()     )
	-- log._("dsp1_itm_idx_max" , _s:dsp1_itm_idx_max())
	-- log._("whel_idx_max"     , _s:whel_idx_max()    )
	log._("dsp1_itm_idx"     , _s:dsp1_itm_idx()    )
	log._("dsp1_whel_idx"    , _s:dsp1_whel_idx()   )
	log.pp("whel", _s._whel)
end

