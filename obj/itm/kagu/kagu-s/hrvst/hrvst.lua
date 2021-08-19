log.scrpt("hrvst.lua")

Hrvst = {

	act_intrvl_time = 60,
	name_idx_max    =  1,
	z = 0.1,

	weight = 2,

	rst_cls = {"flpy", "reizoko", "pc", "shelf", "kitchen"},

	unlock_cls = {"flower", "dish"},
}
Hrvst.cls = "hrvst"
Hrvst.fac = Obj.fac..Hrvst.cls
Cls.add(Hrvst)

-- static

function Hrvst.cre(p_pos)
	local t_Cls = Hrvst
	local t_id = Sp.cre(t_Cls, p_pos)
	return t_id
end

-- script method

function Hrvst.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Hrvst)
end

function Hrvst.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Hrvst.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s:upd_pos_static()

	_s:upd_final()
end

function Hrvst.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end
	
	
end

function Hrvst.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if ha.eq(msg_id, "__in") then
		_s:__in(prm)
	end
end

function Hrvst.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Hrvst.__in(_s, prm)
	
	local t_id    = prm.id
	-- local t_clsHa = id.prp(t_id, "_clsHa")

	pst.scrpt(t_id, "__to_hrvst")
end

