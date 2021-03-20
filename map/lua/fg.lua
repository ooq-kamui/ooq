log.scrpt("fg.lua")

Fg = {
	_ = {},
}

-- static

function Fg.add(p_tilemap, area, p_id)
	Fg._[p_tilemap] = {}
	Fg._[p_tilemap].id = p_id
	Fg._[p_tilemap].url = url._(p_id, p_tilemap)
	Fg._[p_tilemap].area = area
end

-- script

function Fg.init(_s)
	extend._(_s, Fg)
end

function Fg.upd(_s, dt)
	-- log._("fg upd scrl_rate", _s.area, _s.name, log.f(_s.scrl_rate))

	local cmr_pos = id.pos(Sys.cmr_id())
	local pos = cmr_pos * (1 - _s._scrl_rate)
	id.pos__(id._(), pos)
	-- id.pos__(go.get_id(), pos)
end

function Fg.on_msg(_s, msg_id, prm, sndr)
end

