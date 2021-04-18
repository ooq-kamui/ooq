log.scrpt("map_obj.lua")

function Map.add_chara(chara)

	ar.add_unq(Map.chara, chara)
end

function Map.add_chara_clb_fe(chara)

	ar.add_unq(Map.chara_clb.fe, chara)
end

-- obj

Map._obj = {}
Map._obj.grp = {
	"food",
	"living",
	"kagu",
	"elm",
	"itm",
}
Map._obj._ = {} -- < Map.cnt


-- static

Map.st = {}

function Map.st.obj__init(p_cls)

	local clsHa = ha._(p_cls)
	Map._obj._[clsHa] = {}
end

function Map.st.obj(p_cls)

	local clsHa = ha._(p_cls)

	return Map.st.obj_by_ha(clsHa)
end

function Map.st.obj_by_ha(p_clsHa)

	if not Map._obj._[p_clsHa] then return end

	return Map._obj._[p_clsHa]
end

function Map.st.obj_cnt(p_cls)

	local obj = Map.st.obj(p_cls)

	if not obj then return end

	local cnt = #obj
	return cnt
end

-- method

function Map.obj_2_save_data(_s)
	local obj = _s:obj()
	return obj
end

function Map.obj(_s)

	local data = {}
	for idx, grp in pairs(Map._obj.grp) do
		-- log._("Map.obj", grp)
		data[grp] = _s["obj_"..grp](_s)
	end

	-- log.pp("data obj kagu", data["kagu"])
	return data
end

function Map.obj_kagu(_s)
	local cls = {
		"hrvst", "trmpln",
		"kitchen", "reizoko",
		"flpy", "pc", "shelf", "doorwrp",
		"kagu",
	}
	return _s:obj_grp(cls)
end

function Map.obj_food(_s)
	local cls = Food.cls
	return _s:obj_grp(cls)
end

function Map.obj_living(_s)
	local cls = {
		"anml", "bush", "flower", "fluff", "mshrm", "plant", "seed", "tree",
	}
	return _s:obj_grp(cls)
end

function Map.obj_elm(_s)
	-- local cls = {"warp"}
	local cls = {"mgccrcl", "mgcpot",}
	return _s:obj_grp(cls)
end

function Map.obj_itm(_s)
	local cls = {"parasail", "parasol",}
	return _s:obj_grp(cls)
end

function Map.obj_grp(_s, p_cls)
	local data = {}
	for idx, cls in pairs(p_cls) do
		data[cls] = _s:obj_cls(ha._(cls))
	end
	return data
end

function Map.obj_cls(_s, clsHa)
	-- log._("Ply_data.data_obj_cls", clsHa)

	local data_cls = {}

	local t_obj = Map.st.obj_by_ha(clsHa)

	if not t_obj then return data_cls end

	local prm

	for j, t_id in pairs(t_obj) do
		-- log._("Map.obj_cls()", clsHa)

		prm = {name = ha.de(id.name(t_id)), pos = id.pos_w(t_id)}
		-- prm = {name = ha.de(id.name(t_id)), pos = id.wpos(t_id)}

		if     ar.inHa(clsHa, {"seed"}) then
			prm.grw_cls   = id.prp_de(t_id, "_grw_clsHa"  )
			prm.grw_name  = id.prp_de(t_id, "_grw_nameHa" )
			prm.bear_cls  = id.prp_de(t_id, "_bear_clsHa" )
			prm.bear_name = id.prp_de(t_id, "_bear_nameHa")

		elseif ar.inHa(clsHa, {"tree"}) then
			prm.bear_cls  = id.prp_de(t_id, "_bear_clsHa" )
			prm.bear_name = id.prp_de(t_id, "_bear_nameHa")

		elseif ar.inHa(clsHa, {"mshrm"}) then
			-- log.pp("Map.obj_cls mshrm", prm)
		end
		ar.add(data_cls, prm)
	end
	return data_cls
end

-- cre

function Map.cloud__cre(_s, prm)

	local t_pos
	if prm and prm.pos then
		t_pos = prm.pos
	else
		t_pos = Cloud.pos_init
	end
	
	_s._cloud_id = Cloud.cre(t_pos, prm)
end

function Map.plychara__cre(_s, p_pos, dir)
	-- log._("Map.plychara__cre", p_pos, dir)
	_s._plychara_id = Plychara.cre(p_pos, dir)
end

function Map.fairy__cre(_s, p_pos, prm)
	_s._fairy_id = Fairy.cre(p_pos, prm)
end

function Map.obj__cre_dflt() -- not use
end

function Map.obj__new(_s)

	_s:obj__new_kagu()

	Mgccrcl.cre(n.vec(-936, -1464))
	Mgccrcl.cre(n.vec( 936, -1464))
end

function Map.obj__(_s, data)

	-- log.pp("obj__", data)

	for idx, grp in pairs(Map._obj.grp) do
		_s:obj_grp__load(data, grp)
	end
end

function Map.obj_grp__load(_s, data, grp) -- -> func name rename

	if not data[grp] then return end
	-- log.pp("obj_grp__load:"..grp, data[grp])

	local tCls, prm
	for cls, ar in pairs(data[grp]) do
		-- log._("cls", cls, "grp", grp)
		tCls = Cls._(cls)

		for idx, tb in pairs(ar) do
		-- log._("name", tb["name"])
			
			prm = {name = ha._(tb["name"])}
			if     cls == "seed" then
				prm.grw_cls   = ha._(tb["grw_cls"])
				prm.grw_name  = ha._(tb["grw_name"])
				prm.bear_cls  = ha._(tb["bear_cls"])
				prm.bear_name = ha._(tb["bear_name"])
			elseif cls == "tree" then
				prm.bear_cls  = ha._(tb["bear_cls"])
				prm.bear_name = ha._(tb["bear_name"])
			end
			tCls.cre(tb["pos"], prm)
			-- log._("load obj cre", tb["name"], tb["pos"])
		end
	end
end

function Map.obj__new_kagu(_s)

	local pos_init = Cloud.pos_init -- refactoring

	-- box create
	local t_pos
	t_pos = pos_init + n.vec(- Map.sq * 1, 0)
	Hrvst.cre(t_pos)

	-- reizoko create
	t_pos = pos_init + n.vec(- Map.sq * 4, Map.sq * 5)
	Reizoko.cre(t_pos)

	-- kitchen create
	local init_x = Map.sq * 4
	local w = 2 -- Map.sq * w
	local x
	local cnt = 2
	for i = 1, cnt do
		x = init_x + Map.sq * w * i
		t_pos = pos_init + n.vec(- x, Map.sq * 5)
		Kitchen.cre(t_pos)
	end

	-- Save create
	t_pos = pos_init + n.vec(Map.sq * 1, 0)
	Flpy.cre(t_pos)

	-- Pc create
	t_pos = pos_init + n.vec(Map.sq * 2, Map.sq * 1) -- 10)
	Pc.cre(t_pos)

	-- Shelf create
	t_pos = pos_init + n.vec(Map.sq * 3, Map.sq * 1) -- 10)
	Shelf.cre(t_pos)
end

