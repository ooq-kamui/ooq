log.scrpt("fluff.lua")

Fluff = {
	act_intrvl_time = 14,
	name_idx_max    = 1,

	foot_dst_i = 20,
	speed      = 2, -- 50,
}
Fluff.cls = "fluff"
Fluff.fac = Obj.fac..Fluff.cls
Cls.add(Fluff)

-- static

function Fluff.cre(t_pos, prm)
	local t_Cls = Fluff
	local t_id = Sp.cre(t_Cls, t_pos, prm)
	return t_id
end

-- script method

function Fluff.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Livingmove)
	extnd._(_s, Hldabl)
	extnd._(_s, Fluff)
end

function Fluff.__init(_s, prm)

	Sp        .__init(_s, prm)
	Livingmove.__init(_s)
	Hldabl    .__init(_s)
end

function Fluff.upd(_s, dt)

	-- _s:act_intrvl(dt)

	_s:upd_pos_movabl(dt)

	_s:upd_final()
end

function Fluff.act_intrvl(_s, dt)

	-- if not _s:is_loop__act_intrvl__(dt) then return end

	if _s:per_trnsf__humus(1) then return end

	if _s:per_trnsf(5, Seed ) then return end

	-- obj cre
	dice100.throw()
	if     dice100.chk(10) then
		Seed.cre()
	end
	
	_s:moving_prp__rnd()
end

function Fluff.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Fluff.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

