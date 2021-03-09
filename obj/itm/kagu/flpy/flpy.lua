log.scrpt("flpy.lua")

Flpy ={
	act_intrvl_time = 50,
	name_idx_max = 1,
	z = 0.1,
}
Flpy.cls = "flpy"
Flpy.fac = "kaguFac"
Cls.add(Flpy)

-- static

function Flpy.cre(pos, prm)
	local Cls = Flpy
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Flpy.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Flpy)
end

function Flpy.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Flpy.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Flpy.on_msg(_s, msg_id, prm, sender)
	
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
	
	if     ar.inHa(msg_id, {"opn"}) then
		_s:opn()
	end
end

function Flpy.final(_s)
	
	Sp.final(_s)
	Hldabl.final(_s)
end

-- -- method

function Flpy.opn(_s)
	
	local gui_id = fac.cre("#fac_flpy_gui")
	local ply_slt_idx = _s:ply_slt_idx()
	pst.gui(gui_id, "gui:prp__", {ply_slt_idx = ply_slt_idx})
end
