log.scrpt("Fuki.lua")

Fuki = {

	act_intrvl_time = 5,
	name_idx_max    = 1,
	z = 0.4,

	id = nil,
	scrpt = nil,

	pos_df = n.vec(0, Map.sq * 3 / 2 + 3),
	mv_vec = n.vec(0, 0.5),
}
Fuki.cls = "fuki"
Fuki.fac = Obj.fac..Fuki.cls
Cls.add(Fuki)

function Fuki.cre(p_pos, prm, scl)

	local t_Cls = Fuki

	p_pos = p_pos or pos.pos() + Fuki.pos_df

	prm = prm or {}
	local t_id = Sp.cre(t_Cls, p_pos, prm, scl)
	return t_id
end

-- script method

function Fuki.init(_s)

	extend._(_s, Sp)
	extend._(_s, Fuki)
end

function Fuki.__init(_s, prm)
	
	Sp.__init(_s, prm)
end

function Fuki.upd(_s, dt)

	_s:act_intrvl(dt)
	
	_s:pos__(_s:pos() + Fuki.mv_vec)
end

function Fuki.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	-- log._("fuki pos", _s:pos())

	local anim = {}
	anim[1] = function ()
		go.animate(_s._id, "scale", es.fwd, n.vec(), es.sin_io, 0.3, 0, anim[2])
	end
	anim[2] = function ()
		go.delete(_.t)
	end
	anim[1]()
end

function Fuki.on_msg(_s, msg_id, prm, sndr_url)

	if     ha.eq(msg_id, "__init") then
		_s:__init(prm)

	elseif ha.eq(msg_id, "s"     ) then
		_s:s(prm.str, prm.len)
	end
end

-- method

function Fuki.s(_s, str, len)
	
	label.set_text("#label", str)
	
	local scale_x, w
	w = (len * 21 + 60)
	-- log._("w", w)
	scale_x = w / 240
	
	if scale_x < 1 then scale_x = 1 end
	go.set("#sprite", "scale.x", scale_x)
	
	-- _s:anm_scl__1()
	-- go.set_scale(1)
end

