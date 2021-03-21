log.scrpt("anml.lua")

Anml = {
	act_intrvl_time = 10,
	speed = 2, -- 50,

	weight = 2,

	-- anml all
	anml = {
		"cat" , "pig"   , "dog"  , "fox"   , "sheep" , "duck",
		"owl" , "rat"   , "goat" , "piyoco", "wolf"  , "coco",
		"bird", "rabbit", "horse", "cow"   , "badger",
	},
	
	bird = {"duck", "owl", "piyoco", "coco", "bird"},
	put_dairy = {"sheep", "cow", "goat"},
	-- enemy = {"cow", "ant",},
}
Anml.cls = "anml"
Anml.fac = "/objFac/"..Anml.cls.."Fac"
Cls.add(Anml)
ha.add_by_ar(Anml.anml)

-- static

function Anml.cre(p_pos, prm)
	
	p_pos = p_pos or pos.pos()

	prm = prm or {}
	
	prm.clsHa  = ha._(Anml.cls)
	if not prm.nameHa then
		prm.nameHa = ha._(rnd.ar(Anml.anml))
	end
	prm.animHa = ha._("walk")

	local map_id, game_id = Game.map_id()
	if ha.is_emp(map_id) then return end
	
	prm.game_id   = game_id
	prm.map_id    = map_id
	prm.parent_id = map_id
	
	local t_url = url._(Anml.fac, prm.nameHa)
	ar.key___(prm)
	-- log.pp("anml cre" .. t_url, prm)
	local t_id = fac.cre(t_url, p_pos, nil, prm)
	-- local t_id = factory.create(t_url, p_pos, nil, prm)

	return t_id
end

-- script method

function Anml.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Livingmove)
	extend.init(_s, Hldabl)
	extend._(_s, Anml)
end

function Anml.upd(_s, dt)
	
	_s:act_intrvl(dt)

	_s:upd_pos_movabl(dt)

	_s:upd_final()
end

function Anml.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- log._("anml z", _s:z())
	
	if not rnd.by_f(1/3) then return end
	
	dice100.throw()
	if     dice100.chk(1) then
		_s:trnsf(Grave)
		
	elseif dice100.chk(5) then
		if     _s:is_bird() then
			Egg.cre()
		elseif _s:is_put_dairy() then
			Dairy.cre()
		end
	elseif dice100.chk(3) then
		_s:trnsf(Meat)
	end

	_s:moving_prp__rnd()
end

function Anml.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
	
	if ha.eq(msg_id, "present") then
		_s:present(prm.id)
	end
end

function Anml.present(_s, o_id)
	
	local o_cls  = id.cls( o_id)
	local o_name = id.name(o_id)
	
	if not _s:is_favo(o_cls, o_name) then return end
	
	id.del(o_id)
	Emtn.cre(_s:pos() + n.vec(0, Map.sqh * 3 / 2))

	-- Zu_anml_gui.anml__o(_s._nameHa)
	Ply_data._zu.anml[_s:name()] = _.t
end

function Anml.is_favo(_s, o_clsHa, o_nameHa)
	-- log.pp("anml is_favo", Mstr.anml)
	-- log._("anml is_favo", o_clsHa, o_nameHa)
	
	local ret = _.f
	
	local s_name = ha.de(_s:name())
	-- log._("anml is_favo", s_name)
	local favo = Mstr.anml[s_name].favo

	local o_cls = ha.de(o_clsHa)
	-- log._("anml is_favo", o_cls)
	if not favo[o_cls] then return ret end

	local o_name = ha.de(o_nameHa)
	ret = ar.in_(o_name, favo[o_cls])

	return ret
end

function Anml.final(_s)
	Sp.final(_s)
	Hldabl.final(_s)
end

-- method

function Anml.is_bird(_s)
	local ret = ar.inHa(_s._nameHa, Anml.bird)
	return ret
end

function Anml.is_put_dairy(_s)
	local ret = ar.inHa(_s._nameHa, Anml.put_dairy)
	return ret
end

