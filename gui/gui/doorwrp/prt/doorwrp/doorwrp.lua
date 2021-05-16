log.scrpt("p.doorwrp.lua")

p.Doorwrp = {}

-- static

function p.Doorwrp.cre(parent_gui)
	local p_Prt = p.Doorwrp
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Doorwrp.init(_s, parent_gui)

	_s._lb = "doorwrp"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(   _s, p.Doorwrp)
	
	_s._itm_pitch = 100
	_s._itm_scrl_dir = "h"

	_s._dsp_idx_max = #Map.obj["doorwrp"] or 0

	_s:itm__by_ar(Map.obj["doorwrp"])
	
	_s._itm_txt = Map.obj["doorwrp"] -- {}
	
	-- nd itm
	local node
	for idx, itm in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("txt")], "doorwrp"..int.pad(idx))
	end
end

-- method

function p.Doorwrp.opn(_s)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Doorwrp.decide(_s)

	local doorwrp_id = _s:cursor_itm()

	if u.eq(doorwrp_id, _s._parent_gui._slfobj_id) then
		_s:cursor_itm_iyaiya()
		return
	end

	pst._("#script", "to_doorwrp", {doorwrp_id = doorwrp_id})
	-- _s._parent_gui._slfobj_id = doorwrp_id

	_s:clz()
end

function p.Doorwrp.slfobj__(_s) -- use not
	-- log._("p.Doorwrp.slfobj__", _s._parent_gui._slfobj_id)

	-- _s:cursor_pos__()
end

