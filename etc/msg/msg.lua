log.scrpt("msg.lua")

Msg = {
	idx = 0,
}

-- static

function Msg.s(txt)

	-- log._("Msg.s", txt)

	local msg_id = Sys.msg_id()

	if ha.is_emp(msg_id) then msg_id = Msg.cre() end

	pst.gui(msg_id, "itm__add", {itm = txt})

	Msg.idx = Msg.idx + 1
end

function Msg.cre()
	-- log._("Msg.cre")

	local msg_id = fac.cre("/sys#fac_msg_gui")

	Sys.prp__("_msg_id", msg_id)

	-- pos__d
	local dia_id = Game.dia_id()
	if not ha.is_emp(dia_id) then pst._(msg_id, "base_pos__d") end

	return msg_id
end

function Msg.base_pos__()
	-- log._("Msg.base_pos__")

	local msg_id = Sys.msg_id()

	if ha.is_emp(msg_id) then return end

	pst.gui(msg_id, "base_pos__")
end

function Msg.base_pos__d()
	-- log._("Msg.base_pos__d")

	local msg_id = Sys.msg_id()

	if ha.is_emp(msg_id) then return end

	pst.gui(msg_id, "base_pos__d")
end

