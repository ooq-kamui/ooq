log.script("msg.lua")

Msg = {
	idx = 0,
}

-- static

function Msg.cre()
	log._("Msg.cre")

	local msg_id = fac.cre("/sys#fac_msg_gui")
	return msg_id
end

function Msg.s(txt)

	log._("Msg.s", txt)

	-- txt = txt.." "..int.pad(Msg.idx)

	local msg_id = Sys.msg_id()
	pst.gui(msg_id, "itm__add", {itm = txt})

	Msg.idx = Msg.idx + 1
end

function Msg.base_pos__()
	log._("Msg.base_pos__")

	local msg_id = Sys.msg_id()
	pst.gui(msg_id, "base_pos__")
end

function Msg.base_pos__d()
	log._("Msg.base_pos__d")

	local msg_id = Sys.msg_id()
	pst.gui(msg_id, "base_pos__d" )
end

