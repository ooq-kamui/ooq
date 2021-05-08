log.scrpt("hrvst.lua")

Hrvst = {

	act_intrvl_time = 10,
	name_idx_max = 1,
	z = 0.1,

	weight = 2,
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

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Hrvst)
end

function Hrvst.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Hrvst.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Hrvst.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	
end

function Hrvst.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if ha.eq(msg_id, "in") then
		_s:box_in(prm)
	end
end

function Hrvst.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Hrvst.box_in(_s, prm)
	
	local t_id     = prm.id
	local t_clsHa  = id.prp(t_id, "_clsHa" )
	local t_nameHa = id.prp(t_id, "_nameHa")
	
	if ar.inHa(t_clsHa, {"cloud"}) then return end
	
	if ar.inHa(t_clsHa, {"flpy", "reizoko", "pc", "shelf", "kitchen"})
	and Map.st.obj_cnt(t_clsHa) <= 1 then

		Msg.s("last one.., can not release")
		return
	end

	local gold = Mstr.gold(t_clsHa, t_nameHa)
	-- log._("in box", t_cls, t_nameHa, gold)

	Ply_data.gold__add(gold)
	Se.pst_ply("coin")

	-- Gold.cre(_s:plychara_pos(), {price = gold})
	local plychara_pos = _s:plychara_pos()
	-- Efct.cre_gold( plychara_pos + t.vec( 0, Map.sq * 2))
	Efct.cre_gold( plychara_pos )

	local t_prm = {txt = "x "..gold}
	-- log._("gold prm", t_prm.txt)
	Efct.cre_label(plychara_pos + t.vec( 0, Map.sq), t_prm)

	id.del(t_id)

	-- zu unlock
	if     ha.eq(t_cls, "flower") then
		Ply_data._zu.flower[t_nameHa] = _.t

	elseif ha.eq(t_cls, "dish") then
		Ply_data._zu.dish[t_nameHa] = _.t
	end
end

