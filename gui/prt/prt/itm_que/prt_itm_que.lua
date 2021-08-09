log.scrpt("p.prt_itm_que.lua")

p.Prt_itm_que = {}

function p.Prt_itm_que.init(_s, itm)

	_s._nd.tpl.itm = nd._(_s:lb("itm"))
	_s._tpl_itm_pos = nd.pos(_s._nd.tpl.itm)
	nd.enbl__(_s._nd.tpl.itm, _.f)

	_s._itm    = {}
	_s._nd.itm = {}
end

function p.Prt_itm_que.itm__add(_s, itm)
	-- log.pp("itm__add", itm)

	ar.add(_s._itm, itm)

	local itm_nd_ar = _s:itm_nd__cln()

	return itm_nd_ar
end

function p.Prt_itm_que.itm_nd__cln(_s)

	local itm_nd_ar = p.Prt_itm_lst.whel_i_nd__cln(_s)
	return itm_nd_ar
end

function p.Prt_itm_que.itm__del_1(_s)

	local t_itm_nd = _s._nd.itm[1][_s:lb("itm")]
	
	local anm = {}
	anm[1] = function ()
		nd.anm.fade__o(t_itm_nd, nil, anm[2])
	end
	anm[2] = function ()
		nd.del(t_itm_nd)
		ar.del_1(_s._nd.itm)
		ar.del_1(_s._itm)

		if #_s._itm == 0 then
			_s:clz()
		else
			_s:que__plt_anm()
		end
	end
	anm[1]()
end

function p.Prt_itm_que.itm__plt_anm(_s)
	_s:que__plt_anm()
end

function p.Prt_itm_que.que__plt_anm(_s)

	for itm_idx, dmy in pairs(_s._nd.itm) do
		_s:que_i__plt_anm(itm_idx)
	end
end

function p.Prt_itm_que.que_i__plt_anm(_s, itm_idx)
	
	if _s:is_que_i_dsp(itm_idx) then
		
		_s:que_i_pos__anm(itm_idx)
		nd.enbl__(_s:que_i_nd(itm_idx), _.t)
	else
		nd.enbl__(_s:que_i_nd(itm_idx), _.f)
		_s:que_i_pos__tpl(itm_idx)
	end
end

function p.Prt_itm_que.is_que_i_dsp(_s, itm_idx)

	local ret = _.t
	return ret
end

function p.Prt_itm_que.que_i_pos__anm(_s, itm_idx)

	local dsp_idx = itm_idx

	local t_pos = _s:dsp_pos(dsp_idx)

	local time = 0.7
	nd.anm.mv(_s:que_i_nd(itm_idx), t_pos, nil, time)
end

function p.Prt_itm_que.dsp_pos(_s, dsp_idx) -- refactoring

	local t_pos = p.Prt_itm_lst.dsp_pos(_s, dsp_idx)
	-- log._("p.Prt_itm_que.dsp_pos", t_pos)
	return t_pos
end

function p.Prt_itm_que.que_i_pos__tpl(_s, itm_idx)

	nd.pos__(_s:que_i_nd(itm_idx), _s._tpl_itm_pos)
end

-- nd

function p.Prt_itm_que.que_i_nd(_s, itm_idx)

	local t_itm_nd = _s._nd.itm[itm_idx][_s:lb("itm")]
	-- log._("p.Prt_itm_que.que_i_nd", t_itm_nd)
	return t_itm_nd
end

-- base

function p.Prt_itm_que.base_pos__(_s, p_pos)

	p_pos = p_pos or Disp.center

	p.Prt_base.base_pos__(_s, p_pos)
end

function p.Prt_itm_que.base_pos__d(_s)

	local t_pos = Disp.center + n.vec(0, -200)
	_s:base_pos__(t_pos)
end

