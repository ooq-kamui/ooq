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
	_s._itm_pitch   = 50
	_s._dsp_idx_max =  8
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Kzn)
	
	_s:itm__6_ar(Chara.chara)
	_s:whel__init()

end

function p.Kzn.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)
	local chara = _s:itm_i(itm_idx)
	local point = Ply_data.kzn._kzn[chara] or 0

	local txtr
	local anim

	if point > 0 then
		txtr = "chara"
		anim = chara.."-stand"
	else
		txtr = "noimg"
		anim = "noimg"
	end

	nd.txtr__(nd_ar[_s:lb("img")], txtr)
	nd.anm__( nd_ar[_s:lb("img")], anim)
	nd.txt__( nd_ar[_s:lb("txt")], int._2_str(point))
end

-- method

function p.Kzn.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
end

function p.Kzn.decide(_s)
end

