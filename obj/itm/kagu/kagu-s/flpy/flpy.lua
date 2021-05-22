log.scrpt("flpy.lua")

Flpy ={
	act_intrvl_time = 50,
	name_idx_max    =  1,
	z = 0.1,
}
Flpy.cls = "flpy"
Flpy.fac = Obj.fac..Flpy.cls
Cls.add(Flpy)

-- static

function Flpy.cre(p_pos, prm)
	local t_Cls = Flpy
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Flpy.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Flpy)
end

function Flpy.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Flpy.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Flpy.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	
end

function Flpy.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if ar.inHa(msg_id, {"opn"}) then
		_s:opn()
	end
end

function Flpy.final(_s)
	
	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Flpy.opn(_s)
	
	local t_id = fac.cre("#fac_flpy_gui")
	local ply_slt_idx = _s:ply_slt_idx()
	pst.gui(t_id, "gui:prp__", {_ply_slt_idx = ply_slt_idx})
end

