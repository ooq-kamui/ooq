log.script("chara.lua")

Chara = {
	
	act_interval_time = 8,
	speed = 50,
	
	chara = {
		"sanae",
		"marin",
		"katia",
		"sayaka",
		"yuki",
		"kurumi",
		"matilda",
		"lily",
		"sofia",
		"shiki",
		"kageri",
	},
	flyabl = {
		"katia",
		"lily",
		"sofia",
	},
	presentabl = {"flower","dish","fruit","dairy","egg","veget",}, -- cls
}
Chara.cls = "chara"
Chara.fac = "/objFac#chara"
Chara.Fac = Obj.fac..Chara.cls
Cls.add(Chara, Chara.chara)

-- static

function Chara.cre(pos, name)
	
	if Map.chara_is_appear_all() then return end
	
	pos  = pos  or go.get_world_position()
	name = name or Chara.new_name()
	
	local prm = {}
	prm.cls  = ha._("chara")
	prm.name = ha._(name)
	prm.anim = ha._(name)
	prm.is_fly = Chara.is_flyabl(name)
	
	-- game_id, map_id, parent_id
	local map_id, game_id = Game.map_id()
	if ha.is_emp(map_id) then return end
	
	prm.game_id   = game_id
	prm.map_id    = map_id
	prm.parent_id = map_id
	prm.z = Chara.z

	-- log.pp("Chara cre prm", prm)
	ar.key___(prm)
	local t_id = factory.create("/objFac/"..Chara.Fac, pos, nil, prm)
	
	Map.add_chara(name)
	return t_id
end

function Chara.is_flyabl(chara)
	local ret = ar.in_(chara, Chara.flyabl)
	return ret
end

function Chara.new_name()
	local not_appear_chara = Map.not_appear_chara()
	local new_name = ar.rnd(not_appear_chara)
	return new_name
end

-- script method

function Chara.init(_s, dt)
	
	extend.init(_s, Sp)
	extend.init(_s, Livingmove)
	extend._(_s, Chara)
	
	_s:say()
	_s:act_interval_time__()
end

function Chara.upd(_s, dt)
	
	_s:act_interval(dt)
	
	_s:upd_pos_movabl(dt)
end

function Chara.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- log._("chara act_interval is_loop", _s:name(), _s._act_interval_time)
	
	dice100.throw()
	if     dice100.chk(1) then
		Seed.cre()
	end

	_s:moving_prp__rnd()
	
	-- say
	if rnd.by_f(2/5) then _s:say() end

	_s:act_interval_time__()
end

function Chara.on_msg(_s, msg_id, prm, sender)

	Sp.on_msg(_s, msg_id, prm, sender)
	
	if ha.eq(msg_id, "present") then
		
		local t_id = prm.id
		local t_cls  = id.cls(t_id)
		if not ar.inHa(t_cls, Chara.presentabl) then return end
		
		id.del(t_id)
		Emtn.cre(_s:pos() + n.vec(0, Map.sqh * 3 / 2))
		_s:kzn__pls()
	end
end

function Chara.kzn__pls(_s, point)

	point = point or Mstr.kzn.point

	if not Ply_data._kzn[_s:name()] then
		Ply_data._kzn[_s:name()] = 0
	end

	Ply_data._kzn[_s:name()] = Ply_data._kzn[_s:name()] + point
end

-- function Chara.final(_s)
-- end

-- --

function Chara.act_interval__(_s, dt)
	local is_loop
	_s._act_interval, is_loop = u.pls_loop(_s._act_interval, dt, _s._act_interval_time)
	return is_loop
end

function Chara.act_interval_time__(_s)
	_s._act_interval_time = _s:Cls().act_interval_time + rnd.int(0, 3)
end
