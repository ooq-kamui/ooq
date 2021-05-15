log.scrpt("flower.lua")

Flower = {
	act_intrvl_time = 100,
	name_idx_max    = 159,
}
Flower.cls = "flower"
Flower.fac = Obj.fac..Flower.cls
Cls.add(Flower)

-- static

function Flower.cre(p_pos, prm)
	local t_Cls = Flower
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Flower.init(_s)

	extend._(_s, Sp)
	extend._(_s, Hldabl)
	extend._(_s, Flower)
end

function Flower.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Flower.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Flower.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1 / 15 * 100) then return end
	
	if _s:per_trnsf(10, Seed) then return end

	if _s:per_trnsf(10, Fluff) then return end
end

function Flower.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Flower.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

