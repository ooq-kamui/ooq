log.script("p.door.lua")

p.Door = {}

-- static

function p.Door.cre(parent_gui)
	local p_Prt = p.Door
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Door.init(_s, parent_gui)

	_s._lb = "door"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Door)
	
	_s._itm_pitch = 100
	_s._itm_scrl_dir = "h"
	_s._dsp_idx_max = #Map.cnt[ha._("door")]

	--[[
	_s._itm     = Map.cnt[ha._("door")] -- {}
	_s:itm_len__()
	_s:dsp1_itm_idx_max__()
	--]]
	_s:itm__by_ar(Map.cnt[ha._("door")])
	
	_s._itm_txt = Map.cnt[ha._("door")] -- {}
	
	-- nd itm
	local node
	for idx, itm in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("txt")], "door"..int.pad(idx))
	end
end

-- method

function p.Door.decide(_s)
	local door_id = _s:cursor_itm()
	-- log._("door decide door_id", door_id)
	pst._("#script", "to_door", {door_id = door_id})
end
