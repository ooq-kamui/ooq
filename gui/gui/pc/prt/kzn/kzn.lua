log.scrpt("p.kzn.lua")

p.Kzn = {}

-- static

function p.Kzn.cre(parent_gui)
	local p_Prt = p.Kzn
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Kzn.init(_s, parent_gui)

	_s._lb = "kzn"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Kzn)
	
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
	_s:itm_point__()
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Kzn.itm_icn__(_s)
	
	local node

	for idx, chara in pairs(_s._itm) do

		node = _s._nd.itm[idx]

		if Ply_data.kzn._kzn[chara] then
			nd.txtr__(node[_s:lb("img")], "chara")
			nd.anm__( node[_s:lb("img")], chara.."-stand")
		else
			nd.txtr__(node[_s:lb("img")], "noimg")
			nd.anm__( node[_s:lb("img")], "noimg")
		end
	end
end

function p.Kzn.itm_point__(_s)
	
	local point, node

	for idx, chara in pairs(_s._itm) do

		node = _s._nd.itm[idx]

		if Ply_data.kzn._kzn[chara] then
			point = Ply_data.kzn._kzn[chara]
		else
			point = 0
		end
		nd.txt__(node[_s:lb("txt")], int._2_str(point))
	end
end

function p.Kzn.decide(_s)
end

