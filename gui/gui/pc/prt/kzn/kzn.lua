log.scrpt("p.kzn.lua")

p.Kzn = {}

-- static

function p.Kzn.cre(parent_gui)
	local p_Prt = p.Kzn
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

function p.Kzn.add(name) -- name:hash
	
	if not Ply_data._kzn[name] then
		Ply_data._kzn[name] = 0
	end
	
	Ply_data._kzn[name] = Ply_data._kzn[name] + p.Kzn.point
end

-- script method

function p.Kzn.init(_s, parent_gui)

	_s._lb = "kzn"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Kzn)
	
	_s._itm_pitch = 50
	_s._dsp_idx_max = 8
	
	_s:itm__by_ar(Chara.chara)
	
	local node
	for idx, chara in pairs(_s._itm) do
		node = _s:itm_clone()
	end
end

-- method

function p.Kzn.opn(_s, prm)
	
	_s:itm_icn__()
	_s:item_point__()
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Kzn.itm_icn__(_s)
	
	local charaHa, node, anim
	-- log.pp("n.item", _s._nd.itm)
	for idx, chara in pairs(_s._itm) do
		charaHa = ha._(chara)
		node = _s._nd.itm[idx]
		if Ply_data._kzn[charaHa] then
			nd.txtr__(node[_s:lb("img")], "chara")
			-- gui.play_flipbook(node[_s:lb("img")], charaHa)

			anim  = chara .. "-stand"
			nd.anm__(node[_s:lb("img")], anim)
			-- nd.anm__(node[_s:lb("img")], charaHa)

		else
			nd.txtr__(node[_s:lb("img")], "noimg")
			-- gui.play_flipbook(node[_s:lb("img")], "noimg")
			nd.anm__(node[_s:lb("img")], "noimg")
		end
	end
end

function p.Kzn.item_point__(_s)
	
	local point, charaHa, node
	for idx, chara in pairs(_s._itm) do
		charaHa = ha._(chara)
		node = _s._nd.itm[idx]
		if Ply_data._kzn[charaHa] then
			point = Ply_data._kzn[charaHa]
		else
			point = 0
		end
		nd.txt__(node[_s:lb("txt")], int._2_str(point))
	end
end

function p.Kzn.decide(_s)
end

