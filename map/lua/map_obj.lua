log.scrpt("map_obj.lua")

-- static

function Map.add_chara(chara)

	ar.add_unq(Map.chara, chara)
end

function Map.add_chara_clb_fe(chara)

	ar.add_unq(Map.chara_clb.fe, chara)
end

function Map.add_chara_clb_tohoku(chara)

	ar.add_unq(Map.chara_clb.tohoku, chara)
end

-- obj

Map._obj = {}

Map._obj.grp_cls = {

	-- food = Food.cls, -- def at Food

	living = {
		"anml",
		"flower", "fluff", "mshrm", "seed", "tree",
		"plant", "bush",
	},
	kagu = {
		"kagu",
		"kitchen", "reizoko",
		"flpy", "pc", "shelf",
		"doorwrp",
		"hrvst", "trmpln",
	},
	elm = {
		"mgccrcl", "mgcpot",
	},
	itm = {
		"parasail", "parasol",
	},
}

-- static

-- Map.st = {} -- old

-- method

-- obj

function Map.obj__add(_s, p_id, p_cls)

	if not _s._obj[p_cls] then _s._obj[p_cls] = {} end
	
	ar.add_unq(_s._obj[p_cls], p_id)
end

function Map.obj__del(_s, p_id, p_cls)

	if not _s._obj[p_cls] then return end

	ar.del_by_val(_s._obj[p_cls], p_id)

	-- log.pp("Map.obj__del "..p_cls, _s._obj[p_cls])
end

function Map.obj_cnt(_s, p_cls)

	local cnt

	if not _s._obj[p_cls] then cnt = 0
	else                       cnt = #_s._obj[p_cls]
	end

	return cnt
end

function Map.obj_cnt_all(_s) -- log

	local cnt
	for t_cls, id_ar in pairs(_s._obj) do
		
		cnt = _s:obj_cnt(t_cls)

		-- log.pp("Map.obj_cnt_all "..t_cls.." "..cnt, id_ar)
	end
end

function Map.obj__save_data_obj_ar(_s, p_sd_obj_tb)

	for grp, t_cls_ar in pairs(Map._obj.grp_cls) do

		-- log.pp("grp:", grp)

		for t_cls_idx, t_cls in pairs(t_cls_ar) do

			-- log._("cls:", t_cls)

			if not p_sd_obj_tb[t_cls] then
			else
				for t_obj_idx, t_obj in pairs(p_sd_obj_tb[t_cls]) do

					-- log._("obj:", t_obj._name, t_obj._cls)

					_s:obj__save_data_obj(t_obj)	
				end
			end
		end
	end
end

function Map.obj__save_data_obj(_s, p_obj)

	local t_cls = p_obj._cls
	local t_Cls = Cls.Cls(t_cls)
	local prm = {}
	prm._name = p_obj._name

	if t_Cls.cre_prm then
		for idx, prp in pairs(t_Cls.cre_prm) do
			prm[prp] = p_obj[prp]
		end
	end

	t_Cls.cre(p_obj["_pos"], prm)
end

-- save

function Map.pf__save_data_obj__(_s)

	for grp, t_cls_ar in pairs(Map._obj.grp_cls) do

		for idx, t_cls in pairs(t_cls_ar) do
			_s:pf__obj_grp_cls(t_cls)
		end
	end
end

function Map.pf__obj_grp_cls(_s, p_cls)

	local t_obj = _s._obj[p_cls]

	if not t_obj then --[[ log._("Map.obj_cls nil :", p_cls) --]] return end

	for idx, t_id in pairs(t_obj) do

		pst.scrpt(t_id, "pf__save_data")
	end
end

function Map.save_data_obj__clr(_s)

	ar.clr(_s._save_data.obj)
end

function Map.save_data_obj__(_s, prm)
	-- log.pp("Map.save_data_obj__", prm)

	if not _s._save_data.obj           then _s._save_data.obj           = {} end
	if not _s._save_data.obj[prm._cls] then _s._save_data.obj[prm._cls] = {} end

	ar.add(_s._save_data.obj[prm._cls], prm)
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
	_s._plychara_id = Plychara.cre(p_pos, dir)
end

function Map.fairy__cre(_s, p_pos, prm)
	_s._fairy_id = Fairy.cre(p_pos, prm)
end

function Map.obj__cre_dflt() -- not use
end

-- game start / map new

function Map.obj__new(_s)

	_s:obj__new_kagu()

	local t_pos = n.vec( 936, -1464)
	Mgccrcl.cre(t_pos)
	t_pos.x = - t_pos.x
	Mgccrcl.cre(t_pos)
end

function Map.obj__new_kagu(_s)

	local pos_init = Cloud.pos_init -- refactoring

	-- box
	local t_pos
	t_pos = pos_init + n.vec(- Map.sq * 1, 0) -- > t.vec()
	Hrvst.cre(t_pos)

	t_pos = pos_init + n.vec(- Map.sq * 5, 0)
	Hrvst.cre(t_pos)

	-- reizoko
	t_pos = pos_init + n.vec(- Map.sq * 4, Map.sq * 5)
	Reizoko.cre(t_pos)

	-- kitchen
	local init_x = Map.sq * 4
	local w = 2 -- Map.sq * w
	local x
	local cnt = 2
	for i = 1, cnt do
		x = init_x + Map.sq * w * i
		t_pos = pos_init + n.vec(- x, Map.sq * 5)
		Kitchen.cre(t_pos)
	end

	-- flpy
	t_pos = pos_init + n.vec(Map.sq * 1, 0)
	Flpy.cre(t_pos)

	-- pc
	t_pos = pos_init + n.vec(Map.sq * 2, Map.sq * 1) -- 10)
	Pc.cre(t_pos)

	-- shelf
	t_pos = pos_init + n.vec(Map.sq * 3, Map.sq * 1) -- 10)
	Shelf.cre(t_pos)
end

