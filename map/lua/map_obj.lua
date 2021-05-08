log.scrpt("map_obj.lua")

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
		"anml", "bush", "flower", "fluff", "mshrm", "plant", "seed", "tree",
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

--[[
Map._obj.grp = {

	"food",
	"living",
	"kagu",
	"elm",
	"itm",
}
--]]

Map._obj._ = {} -- < Map.cnt

-- static

Map.st = {}

-- method

function Map.obj__add(_s, p_id, p_cls)

	if not _s._obj[p_cls] then _s._obj[p_cls] = {} end
	
	ar.add_unq(_s._obj[p_cls], p_id)
end

function Map.obj__del(_s, p_id, p_cls)

	if not _s._obj[p_cls] then return end

	ar.del_by_val(_s._obj[p_cls], p_id)

	--[[
	if not _s._obj[p_cls] then _s._obj[p_cls] = {} end
	
	ar.add_unq(_s._obj[p_cls], p_id)
	--]]
end

function Map.pi__save_data_obj__(_s)

	for grp, t_cls_ar in pairs(Map._obj.grp_cls) do

		for idx, t_cls in pairs(t_cls_ar) do
			_s:pi__obj_grp_cls(t_cls)
		end
	end
end

function Map.pi__obj_grp_cls(_s, p_cls)

	local t_obj = _s._obj[p_cls]

	if not t_obj then log._("Map.obj_cls nil :", p_cls) return end

	for idx, t_id in pairs(t_obj) do

		pst.scrpt(t_id, "pi__save_data")
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

	local t_pos = n.vec( 936, -1464)
	Mgccrcl.cre(t_pos)
	t_pos.x = - t_pos.x
	Mgccrcl.cre(t_pos)
end

function Map.obj__save_data_objs(_s, p_sd_obj_tb)

	for grp, t_cls_ar in pairs(Map._obj.grp_cls) do

		log.pp("Map.obj__save_data_objs grp:", grp)

		for t_cls_idx, t_cls in pairs(t_cls_ar) do

			log._("Map.obj__save_data_objs cls", t_cls)

			if not p_sd_obj_tb[t_cls] then
			else
				for t_obj_idx, t_obj in pairs(p_sd_obj_tb[t_cls]) do

					log._("Map.obj__save_data_objs obj", t_obj._name, t_obj._cls)

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

	if     t_cls == "seed" then
		prm._grw_cls   = p_obj._grw_cls
		prm._grw_name  = p_obj._grw_name
		prm._bear_cls  = p_obj._bear_cls
		prm._bear_name = p_obj._bear_name

	elseif t_cls == "tree" then
		prm._bear_cls  = p_obj._bear_cls
		prm._bear_name = p_obj._bear_name
	end

	t_Cls.cre(p_obj["_pos"], prm)
end

--[[
function Map.obj__save_data(_s, data, grp)

	if not data[grp] then return end

	log.pp("obj__save_data:"..grp, data[grp])

	local t_Cls, prm

	for t_cls, ar in pairs(data[grp]) do

		log._("cls", t_cls, "grp", grp)

		t_Cls = Cls._(t_cls)

		for idx, t_obj in pairs(ar) do
			-- log._(t_obj._cls, t_obj._name)
			_s:obj__save_data_obj(t_obj)	
		end
	end
end
--]]

--[[
function Map.obj__save_data(_s, data, grp)

	if not data[grp] then return end

	log.pp("obj__save_data:"..grp, data[grp])

	local t_Cls, prm

	for t_cls, ar in pairs(data[grp]) do

		log._("cls", t_cls, "grp", grp)

		t_Cls = Cls._(t_cls)

		for idx, tb in pairs(ar) do
		-- log._("name", tb["name"])
			
			prm = {_nameHa = ha._(tb["_name"])}

			if     t_cls == "seed" then
				prm._grw_clsHa   = ha._(tb["_grw_cls"  ])
				prm._grw_nameHa  = ha._(tb["_grw_name" ])
				prm._bear_clsHa  = ha._(tb["_bear_cls" ])
				prm._bear_nameHa = ha._(tb["_bear_name"])

			elseif t_cls == "tree" then
				prm._bear_clsHa  = ha._(tb["_bear_cls" ])
				prm._bear_nameHa = ha._(tb["_bear_name"])
			end

			t_Cls.cre(tb["_pos"], prm)
		end
	end
end
--]]

-- game start / map new

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

--[[
function Map.st.obj__init(p_cls) -- old
	-- log._("obj__init", p_cls)

	Map._obj._[p_cls] = {}
end

function Map.st.obj(p_cls) -- old

	if not Map._obj._[p_cls] then return end

	return Map._obj._[p_cls]
end

function Map.st.obj_cnt(p_cls) -- old

	local obj = Map.st.obj(p_cls)
	log.pp("obj_cnt "..p_cls, obj)

	if not obj then return end

	local cnt = #obj
	log._("obj_cnt", cnt)
	return cnt
end
--]]

