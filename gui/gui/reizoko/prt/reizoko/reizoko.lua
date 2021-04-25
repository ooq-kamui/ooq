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

	_s._lb  = "reizoko"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_mtrx)
	extend.init(_s, p.Prt_cursor)
	extend.init(_s, p.Prt_cursor_mtrx)
	extend._(   _s, p.Reizoko)

	_s._base_x_diff = Map.sq * 4 -- use ?
	
	-- _s._xy_max = n.vec(6, 6) -- default
	_s:dsp_idx_max__()
	
	_s._itm = Ply_data._reizoko
	_s:food_cre()

	_s:itm_idx_max__()
	_s:page_idx_max__()
end

-- method

function p.Reizoko.opn(_s)
	log._("reizoko opn")
	
	-- _s:food_cre()
	_s:page__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Reizoko.clz(_s)

	p.Prt.clz(_s)
	
	-- _s:food__del()
end

function p.Reizoko.decide(_s)

	local idx
	idx = xy._2_idx(_s._cursor_xy, _s._xy_size)
	idx = idx + _s._xy_size.x * _s._xy_size.y * (_s._page_idx - 1)
	if idx > #_s._nd.itm then return end

	local food = _s._nd.itm[idx]
	
	local txtr = nd.txtr(food[_s:lb("itm")])
	local anim = nd.anim(food[_s:lb("itm")])
	local cnt  = str._2_int(nd.txt(food[_s:lb("itm_cnt")]))
	
	if (not _s._itm[txtr][anim]) or (_s._itm[txtr][anim] <= 0) then return end
	
	cnt = cnt - 1
	_s._itm[txtr][anim] = cnt
	nd.txt__(food[_s:lb("itm_cnt")], cnt)
	if cnt == 0 then
		_s._itm[txtr][anim] = nil
	end

	-- food cre
	Se.pst_ply("pop")
	pst.scrpt(p.Reizoko.id, "food_cre", {_clsHa = txtr, _nameHa = anim})
	
	nd.anm.poyon(_s._nd.cursor)
	nd.anm.poyon(_s._nd.itm[idx][_s:lb("itm")])
end

-- food

function p.Reizoko.food_cre(_s)
	-- log.pp("p.reizoko.food_cre", _s._itm)
	
	local food, dsp_idx, t_xy

	local txtrs = ar.keyHa_srt(_s._itm)
	-- log.pp("p.reizoko.food_cre", txtrs)
	-- log.pp("p.reizoko.food_cre", ha.ha)
	
	local itm_idx = 1
	for i, txtr in pairs(txtrs) do

		local anims = ar.keyHa_srt(_s._itm[txtr])

		for j, anim in pairs(anims) do

			local cnt = _s._itm[txtr][anim]

			food = nd.clone(_s._nd.tpl.itm)
			_s._nd.itm[itm_idx] = food

			nd.txtr__(food[_s:lb("itm")], txtr)
			nd.anm__(food[_s:lb("itm")], anim)
			nd.txt__(food[_s:lb("itm_cnt")], cnt)

			-- enable
			nd.enbl__(food[_s:lb("itm")], _.f)

			itm_idx = itm_idx + 1
		end
	end
	
	-- _s._page_idx_max = page_idx
	-- if _s._page_idx > _s._page_idx_max then _s._page_idx = _s._page_idx_max end
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

