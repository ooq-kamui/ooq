log.scrpt("p.prt_reizoko.lua")

p.Reizoko = {}

-- static

function p.Reizoko.cre(parent_gui)
	local p_Prt = p.Reizoko
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Reizoko.init(_s, parent_gui)
	log._("p.Reizoko.init")

	_s._lb  = "reizoko"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_mtrx)
	extnd.init(_s, p.Prt_cursor)
	extnd.init(_s, p.Prt_cursor_mtrx)
	extnd._(   _s, p.Reizoko)

	-- _s._base_x_diff = Map.sq * 4 -- use ?
	
	_s:dsp_idx_max__()
	
	_s._itm = Ply_data.reizoko._()
	_s._itm_lst = {}

	_s:food_cre()

	_s:itm_idx_max__()
	_s:page_idx_max__()
end

-- method

function p.Reizoko.opn(_s)
	log._("p.Reizoko.opn")
	
	_s:page__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Reizoko.clz(_s)

	p.Prt.clz(_s)
	
end

function p.Reizoko.decide(_s)

	local idx
	idx = xy._2_idx(_s._cursor_xy, _s._xy_size)
	idx = idx + _s._xy_size.x * _s._xy_size.y * (_s._page_idx - 1)
	if idx > #_s._nd.itm then return end

	local t_cls  = _s._itm_lst[idx]._cls
	local t_name = _s._itm_lst[idx]._name
	
	if not _s._itm[t_cls][t_name]      then return end
	if     _s._itm[t_cls][t_name] <= 0 then return end
	
	_s._itm[t_cls][t_name] = _s._itm[t_cls][t_name] - 1

	local food = _s._nd.itm[idx]
	nd.txt__(food[_s:lb("itm_cnt")], _s._itm[t_cls][t_name])

	if _s._itm[t_cls][t_name] == 0 then
		_s._itm[t_cls][t_name] = nil
	end

	Se.pst_ply("pop")

	pst.scrpt(p.Reizoko.id, "food_cre", {_cls = t_cls, _name = t_name})
	
	nd.anm.poyon(_s._nd.cursor)
	nd.anm.poyon(_s._nd.itm[idx][_s:lb("itm")])
end

-- food

function p.Reizoko.food_cre(_s)
	log.pp("p.reizoko.food_cre")
	
	local food, dsp_idx, t_xy
	
	local itm_idx = 1

	for t_cls, t_name_ar in pairs(_s._itm) do

		for t_name, cnt in pairs(_s._itm[t_cls]) do

			food = nd.clone(_s._nd.tpl.itm)
			_s._nd.itm[itm_idx]  = food
			_s._itm_lst[itm_idx] = {_cls = t_cls, _name = t_name}

			nd.txtr__(food[_s:lb("itm"    )], t_cls )
			nd.anm__( food[_s:lb("itm"    )], t_name)
			nd.txt__( food[_s:lb("itm_cnt")], cnt   )

			nd.enbl__(food[_s:lb("itm")], _.f) -- enable

			itm_idx = itm_idx + 1
		end
	end
end

function p.Reizoko.food__del(_s)
	-- log._("reizoko_gui food_del()", #_s._nd.itm)

	for idx, food in pairs(_s._nd.itm) do
		nd.del(food[_s:lb("itm")])
		nd.del(food[_s:lb("itm_cnt")])

		_s._nd.itm[idx] = nil
	end
	-- log.pp("reizoko gui food_del", _s._nd.itm)
end

