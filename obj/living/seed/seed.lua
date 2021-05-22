log.scrpt("seed.lua")

Seed = {

	act_intrvl_time = 14,
	name_idx_max    =  7,

	foot_dst_i = 4,

	cre_prm = {
		"_grw_cls",
		"_grw_name",
		"_bear_cls",
		"_bear_name",
	},
}
Seed.cls = "seed"
Seed.fac = Obj.fac..Seed.cls
Cls.add(Seed)

-- static

function Seed.cre(p_pos, prm)

	-- log.pp("Seed.cre", prm)

	local t_Cls = Seed
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Seed.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Seed)
end

function Seed.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)

	_s:grw_bear__init()
end

function Seed.upd(_s, dt)

	_s:act_intrvl(dt)

	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Seed.on_msg(_s, msg_id, prm, sndr_url)

	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Seed.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

-- method

function Seed.grw_bear__init(_s)

	_s._grw_cls   = _s._grw_cls   or "tree"
	_s._grw_name  = _s._grw_name  or "tree005"
	_s._bear_cls  = _s._bear_cls  or "fruit"
	_s._bear_name = _s._bear_name or "fruit007"

	log._("Seed.grw_bear__init",
		_s._grw_cls,
		_s._grw_name,
		_s._bear_cls,
		_s._bear_name
	)
end

function Seed.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	if _s:per_trnsf__humus(1) then return end

	local grw_Cls, prm

	if     ar.in_(_s._name, {"seed001"}) then
		dice100.throw()
		if dice100.chk(20) then
			grw_Cls = Cls.Cls(_s._grw_cls) or Flower
			prm = {
				_name      = _s._grw_name,
			}
			local t_id = _s:trnsf(grw_Cls, prm)
		end

	elseif ar.in_(_s._name, {"seed005"}) then
		dice100.throw()
		if dice100.chk(20) then
			grw_Cls = Cls.Cls(_s._grw_cls) or Tree
			prm = {
				_name      = _s._grw_name,
				_bear_cls  = _s._bear_cls,
				_bear_name = _s._bear_name,
			}
			local t_id = _s:trnsf(grw_Cls, prm)
			-- local t_id = _s:trnsf(grw_Cls, prm, 0.2)
			-- pst.scrpt(t_id, "anm_scl__1")
		end

	else
		dice100.throw()
		if dice100.chk(20) then
			local t_id = _s:trnsf(Plant)
		end
	end
end

function Seed.pb__save_data(_s, map_url)

	local prm = {}

	prm._cls  = _s._cls
	prm._name = _s._name
	prm._pos  = _s:pos()

	prm._grw_cls   = _s._grw_cls
	prm._grw_name  = _s._grw_name
	prm._bear_cls  = _s._bear_cls
	prm._bear_name = _s._bear_name

	pst._(map_url, "save_data_obj__", prm)
end

