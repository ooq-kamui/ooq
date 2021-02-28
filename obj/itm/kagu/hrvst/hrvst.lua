log.scrpt("hrvst.lua")

Hrvst = {

	act_intrvl_time = 10,
	name_idx_max = 1,
	z = 0.1,

	weight = 2,
}
Hrvst.cls = "hrvst"
Hrvst.fac = "kaguFac"
Hrvst.Fac = Obj.fac..Hrvst.cls
Cls.add(Hrvst)

-- static

function Hrvst.cre(pos)
	local Cls = Hrvst
	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Hrvst.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Hrvst)
	
	-- _s.speed = 0
	-- _s.held = _.f
end

function Hrvst.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)
end

function Hrvst.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	
end

function Hrvst.on_msg(_s, msg_id, prm, sender)
	
	Sp.on_msg(_s, msg_id, prm, sender)
	Hldabl.on_msg(_s, msg_id, prm, sender)
	
	if ha.eq(msg_id, "in") then
		_s:box_in(prm)
	end
end

function Hrvst.final(_s)
	Sp.final(_s)
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
		Msg.s("さいごの１つだよ")
		return
	end

	local t_cls = Cls._(t_clsHa)
	local gold
	if t_Cls and t_Cls.gold then
		gold = t_Cls.gold[t_nameHa]
	else
		gold = 10
	end
	-- log._("in box", t_cls, t_nameHa, gold)
	Ply_data.gold__add(gold)
	Se.pst_ply("coin")
	Gold.cre(_s:plychara_pos(), {price = gold})

	id.del(t_id)

	-- zu unlock
	if     ha.eq(t_cls, "flower") then
		Ply_data._zu.flower[t_nameHa] = _.t

	elseif ha.eq(t_cls, "dish") then
		Ply_data._zu.dish[t_nameHa] = _.t
	end
end

