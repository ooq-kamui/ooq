log.script("p.prt_selected.lua")

p.Prt_selected = {}

function p.Prt_selected.init(_s)

	_s:nd__("selected")

	_s._selected_itm_idx = 1
end

-- method

function p.Prt_selected.selected__cursor_itm(_s)
	
	_s:selected_itm_idx__(_s:cursor_itm_idx())

	-- log._("selected_itm_idx cursor itm idx", _s:cursor_itm_idx())
	_s:selected_nd_parent__(_s:cursor_itm_nd("itm"))
	-- _s:selected_drw()
end

function p.Prt_selected.selected_nd_parent__(_s, p_parent_nd)

	nd.parent__(_s._nd.selected, p_parent_nd)
end

function p.Prt_selected.selected_nd(_s)
	local selected_nd = nd._(_s:lb("selected"))
	return selected_nd
end

function p.Prt_selected.selected_dsp__o(_s)

	local selected_nd = _s:selected_nd()
	if not selected_nd then return end

	nd.anm.dsp__o(selected_nd)
end

function p.Prt_selected.selected_dsp__x(_s)

	local selected_nd = _s:selected_nd()
	if not selected_nd then return end

	nd.anm.dsp__x(selected_nd)
end

function p.Prt_selected.is_selected_dsp(_s)
	
	local ret = _.f
	if num.is_rng(_s._selected_itm_idx, {_s._dsp1_itm_idx, _s:dspE_itm_idx()}) then
		ret = _.t
	end
	return ret
end

function p.Prt_selected.selected_drw(_s)

	if not _s._nd.selected then return end

	if _s:is_selected_dsp() then
		nd.enbl__o(_s._nd.selected)
	else
		nd.enbl__x(_s._nd.selected)
	end
end

function p.Prt_selected.selected_dsp_idx(_s)
	local selected_dsp_idx = _s._selected_itm_idx - _s._dsp1_itm_idx + 1
	return selected_dsp_idx
end

function p.Prt_selected.selected_pos(_s)
	local pos = nd.pos(_s._nd.selected)
	return pos
end

function p.Prt_selected.selected_pos__(_s, p_pos)

	p_pos = p_pos or n.vec()
	nd.pos__(_s._nd.selected, p_pos)
end

function p.Prt_selected.selected_itm(_s)
	return _s._itm[_s._selected_itm_idx]
end

function p.Prt_selected.selected_itm_idx(_s)
	return _s._selected_itm_idx
end

function p.Prt_selected.selected_itm_idx__(_s, itm_idx)
	_s._selected_itm_idx = itm_idx
end

function p.Prt_selected.is_selected_eq_cursor(_s)
	local ret = _.f
	if _s:selected_itm_idx() == _s:cursor_itm_idx() then
		ret = _.t
	end
	return ret
end
