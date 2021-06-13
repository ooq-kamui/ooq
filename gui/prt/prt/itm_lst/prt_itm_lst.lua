log.scrpt("p.prt_itm_lst.lua")

p.Prt_itm_lst = {}

-- init

function p.Prt_itm_lst.init(_s)

	extnd._(   _s, p.Prt_itm_lst)

	_s._nd.tpl.itm = nd._(_s:lb("itm"))
	_s._tpl_itm_pos = nd.pos(_s._nd.tpl.itm)
	nd.enbl__(_s._nd.tpl.itm, _.f)

	_s._itm_scrl_dir = _s._itm_scrl_dir or "v"

	_s._itm = {}
	_s:whel__init()

	_s:dsp1_whel_idx__(1)
	_s:dsp1_itm_idx_max__()
end

-- itm __

function p.Prt_itm_lst.itm__6_ar(_s, p_ar)
	
	_s._itm = p_ar
	_s:dsp1_itm_idx_max__()
end

function p.Prt_itm_lst.itm__6_num(_s, prefix, num)

	for idx = 1, num do
		ar.add(_s._itm, prefix..int.pad(idx))
	end
	
	_s:dsp1_itm_idx_max__()
end

-- itm scrl

function p.Prt_itm_lst.itm__scrl(_s, inc_dir)

	local dsp1_itm_idx

	if     inc_dir == "inc" then
		dsp1_itm_idx = int.inc_stop(_s:dsp1_itm_idx(), _s._dsp1_itm_idx_max)

	elseif inc_dir == "dec" then
		dsp1_itm_idx = int.dec_stop(_s:dsp1_itm_idx(), _s._dsp1_itm_idx_max)
	end

	_s:itm__plt_anm(dsp1_itm_idx)
	Se.pst_ply("cursor__mv")
end

-- itm basic

function p.Prt_itm_lst.itm_idx_max(_s)

	return #_s._itm
end

-- itm i

function p.Prt_itm_lst.itm_i(_s, itm_idx)

	if not _s._itm or not _s._itm[itm_idx] then return end

	return _s._itm[itm_idx]
end

-- itm plt alias

function p.Prt_itm_lst.itm__plt_anm(_s, dsp1_itm_idx) -- alias

	return _s:whel__plt_anm(dsp1_itm_idx)
end

function p.Prt_itm_lst.itm__plt(_s, dsp1_itm_idx) -- alias

	return _s:whel__plt(dsp1_itm_idx)
end

