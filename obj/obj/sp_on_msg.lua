log.scrpt("sp_on_msg.lua")

function Sp.on_msg(_s, msg_id, prm, sndr_url)
	
	local ret = _.t

	if     ha.eq(msg_id, "__init"       ) then
		_s:__init(prm)

	elseif ha.eq(msg_id, "pos__"        ) then
		_s:pos__(prm.pos)
		
	elseif ha.eq(msg_id, "z__"          ) then
		_s:z__(prm.z)
	
	elseif ha.eq(msg_id, "prp__"        ) then -- use ?
		for key, val in pairs(prm) do
			_s:prp__(key, val)
		end
		-- log.pp("sp.on_msg prp__", prm)
		
	elseif ha.eq(msg_id, "anim__"       ) then
		_s:anim__(prm.anim)

	elseif ha.eq(msg_id, "dir_h__"      ) then
		_s:dir_h__(prm.dir_h)
		
	elseif ha.eq(msg_id, "dsp__x"       ) then
		_s:dsp__x()
		
	elseif ha.eq(msg_id, "dsp__o"       ) then
		_s:dsp__o()

	elseif ha.eq(msg_id, "parent__"     ) then
		_s:parent__(prm.parent_id, prm.z, prm.pos)

	elseif ha.eq(msg_id, "parent__map"  ) then
		_s:parent__map(prm.z)
	
	elseif ha.eq(msg_id, "to_cloud"     ) then
		_s:to_cloud()

	elseif ha.eq(msg_id, "leapup"       ) then
		_s:leapup(prm.leapup_lv)

	elseif ha.eq(msg_id, "mv__pos"      ) then
		_s:mv__pos(prm.pos)

	elseif ha.eq(msg_id, "hld__x_thrwd" ) then
		_s:hld__x_thrwd(prm.dir_h)

	elseif ha.eq(msg_id, "anm_scl__1"   ) then
		_s:anm_scl__1()

	elseif ha.eq(msg_id, "anm_pos__"    ) then
		_s:anm_pos__(prm.pos, prm.time)

	elseif ha.eq(msg_id, "pf__save_data") then
		_s:pb__save_data(sndr_url)

	elseif ha.eq(msg_id, "__to_hrvst"   ) then
		_s:__to_hrvst()

	elseif ha.eq(msg_id, "st__"         ) then
		_s:st__(prm.val)

	else
		ret = _.f
	end
	return ret
end

function Sp.hld__x_thrwd(_s, p_dir_h)

	local t_x, t_y = Sp.thrwd_speed_x, Sp.thrwd_speed_y
	if p_dir_h == "l" then t_x = - t_x end
	_s:accl_speed__(t_x, t_y)
end

function Sp.to_cloud(_s)

	local t_pos = _s:cloud_pos()
	_s:pos__(t_pos)
end

function Sp.leapup(_s , p_leapup_lv)

	if not _s:is_leapupabl() then return end

	local dst_y = Plychara.jmp_h_max * p_leapup_lv
	dst_y = dst_y + Plychara.jmp_h_mrgn

	local speed_y = accl.speed_6_dst(dst_y)

	_s._accl:speed_y__(speed_y)
end

function Sp.__to_hrvst(_s)

	if ar.in_(_s._cls, {"cloud"}) then return end
	
	if ar.in_(_s._cls, Hrvst.rst_cls) then

		log._("Hrvst.__in", _s._cls, #Map.obj[_s._cls])
		if #Map.obj[_s._cls] <= 1 then

			Msg.s("last one.., can not release")
			return
		end
	end

	--

	local gold = Mstr.gold(_s._cls, _s._name)

	Ply_data.gold__add(gold)
	Se.pst_ply("coin")

	Efct.cre_gold( _s:plychara_pos() )

	local t_prm = {txt = "x "..gold}
	Efct.cre_label(_s:plychara_pos() + t.vec( 0, Map.sq), t_prm)

	_s:del()

	-- zu unlock
	if not ar.in_(_s._cls, Hrvst.unlock_cls) then return end

	if not Ply_data.zu._zu[_s._cls] then
		Ply_data.zu._zu[_s._cls] = {}
	end

	Ply_data.zu._zu[_s._cls][_s._name] = _.t

	log.pp("Sp.__to_hrvst ".._s._cls, Ply_data.zu._zu[_s._cls])
end

