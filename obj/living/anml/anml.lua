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
Anml.fac = Obj.fac..Anml.cls
Cls.add(Anml)
ha.add_by_ar(Anml.anml)

-- static

function Anml.cre(p_pos, prm)
	
	p_pos = p_pos or pos.pos()

	prm = prm or {}
	
	prm._name = prm._name or rnd.ar(Anml.anml)
	-- prm._anim = "walk"

	local t_Cls = Anml
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Anml.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Livingmove)
	extnd._(_s, Hldabl)
	extnd._(_s, Anml)
end

function Anml.__init(_s, prm)
	
	prm._anim = "-walk"

	Sp        .__init(_s, prm)
	Livingmove.__init(_s)
	Hldabl    .__init(_s)
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

function Anml.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
	
	if ha.eq(msg_id, "present") then
		_s:present(prm.id)
	end
end

function Anml.present(_s, p_id)
	
	local prm = {
		_cls  = _s._cls,
		_name = _s._name,
	}
	pst.scrpt(p_id, "__presentd", prm)
end

function Anml.is_favo(_s, p_cls, p_name)
	
	local ret = Mstr.anml.is_favo(_s:name(), p_cls, p_name)
	return ret
end

function Anml.final(_s)

	Sp    .final(_s)
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

