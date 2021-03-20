log.scrpt("gui.lua")

g = {}
g.Gui = {}

-- -- script method

function g.Gui.init(_s)
	
	_s._prt = {}
	_s._actv_prt = {} -- lb stack

	_s._hndl = {}
end

function g.Gui.on_msg(_s, msg_id, prm, sndr)
	-- log._("g.gui on_msg", msg_id)

	if     ha.eq(msg_id, "gui:opn") then
		_s:opn(nil, prm)
		
	elseif ha.eq(msg_id, "gui:del") then
		_s:del(prm)

	elseif ha.eq(msg_id, "gui:prp__") then
		_s:prp__(prm)
		
	elseif ha.eq(msg_id, "key") then
		-- log.pp("g.gui on_msg key", prm)
		_s:actv_prt_key_2_act(prm)
	end
end

function g.Gui.final(_s)
	for idx, hndl in pairs(_s._hndl) do
		-- log._("gui.final hndl cancel")
		timer.cancel(hndl)
	end
end

-- -- method

function g.Gui.opn(_s, prt_lb, prm)
	
	_s:actv_prt__psh(prt_lb)
	
	_s:actv_prt_opn(prm)
end

function g.Gui.clz(_s)
	-- empty
end

function g.Gui.back(_s)
	-- log._("g.gui back")

	if #_s._actv_prt <= 0 then return end

	_s:actv_prt__pop()

	if #_s._actv_prt <= 0 then
		_s:del()
	else
		_s:actv_prt_opn()
	end
end

function g.Gui.del(_s)
	-- log._("g.gui del")
	pst._("#script", "del")
end

-- actv prt

function g.Gui.actv_prt_lb(_s)

	if #_s._actv_prt <= 0 then return end

	local actv_prt_idx = #_s._actv_prt
	local actv_prt_lb = _s._actv_prt[actv_prt_idx]
	return actv_prt_lb
end

function g.Gui.actv_prt(_s)
	-- log.pp("gui actv_prt", _s._actv_prt)

	if #_s._actv_prt <= 0 then return end

	local actv_prt_lb = _s:actv_prt_lb()
	local actv_prt = _s._prt[actv_prt_lb]
	return actv_prt
end

function g.Gui.actv_prt__psh(_s, prt_lb)
	-- log._("actv_prt__psh", prt_lb)

	if not prt_lb then return end

	_s:actv_prt_actv__x()
	
	ar.psh(_s._actv_prt, prt_lb)
	_s:actv_prt_actv__o()
end

-- function g.Gui.actv_prt__pop(_s, prt_lb)
function g.Gui.actv_prt__pop(_s)

	if #_s._actv_prt <= 0 then return end

	_s:actv_prt_actv__x()
	
	ar.pop(_s._actv_prt)
	_s:actv_prt_actv__o()
end

function g.Gui.actv_prt_actv__x(_s)
	
	local actv_prt = _s:actv_prt()
	-- log.pp("actv_prt_actv__x actv_prt", actv_prt)
	
	if not actv_prt then return end
	
	actv_prt:actv__x()
end

function g.Gui.actv_prt_actv__o(_s)

	local actv_prt = _s:actv_prt()
	
	if not actv_prt then return end
	
	actv_prt:actv__o()
end

function g.Gui.actv_prt_opn(_s, prm)
	local actv_prt = _s:actv_prt()
	actv_prt:opn(prm)
end

function g.Gui.actv_prt_clz(_s, prm)
	local actv_prt = _s:actv_prt()
	actv_prt:clz(prm)
end

function g.Gui.actv_prt_key_2_act(_s, prm)
	
	local actv_prt = _s:actv_prt()

	if not actv_prt then return end
	
	-- log.pp("g.gui actv_prt_key_2_act", prm)
	actv_prt:key_2_act(prm)
end

-- confirm

function g.Gui.confirm(_s)
	local confirm
	if not _s._confirm then return end
	confirm = _s._confirm
	return confirm
end

function g.Gui.confirm_opn(_s, called_by_prt)
	_s:opn("confirm", {called_by_prt = called_by_prt})
end

-- focus

function g.Gui.focus__(_s, val)
	-- log._("g.Gui focus__", val)
	
	local url = url.slf()
	if val then
		pst._(".", "inp_focus__t", {focus_gui_url = url, focus_gui_lb = _s._lb})
	else
		pst._(".", "inp_focus__f")
	end
end

function g.Gui.prp__(_s, prm)
	for key, val in pairs(prm) do
		_s["_"..key] = val
	end
end

