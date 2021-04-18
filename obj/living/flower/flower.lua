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
	local Cls = Flower
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Flower.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(   _s, Flower)
end

function Flower.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Flower.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- death
	if _s:per_trnsf(1 / 15 * 100, Humus) then return end
	
	if _s:per_trnsf(10, Seed) then return end

	if _s:per_trnsf(10, Fluff) then return end
end

function Flower.on_msg(_s, msg_id, prm, sndr)

	Sp.on_msg(    _s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Flower.final(_s)

	Sp.final(    _s)
	Hldabl.final(_s)
end

