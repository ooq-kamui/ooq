log.script("msg.lua")

Msg = {
	idx = 0,
}

-- static

function Sys.msg(txt)
	
end

function Msg.s(txt)

	-- txt = txt.." "..int.pad(Msg.idx)

	local msg_id = Sys.msg_id()
	pst.gui(msg_id, "itm__add", {itm = txt})

	Msg.idx = Msg.idx + 1
end
