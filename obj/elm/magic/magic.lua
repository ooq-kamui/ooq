log.scrpt("magic.lua")

Magic = {

	act_intrvl_time = 0.1,
	name_idx_max = 1,
	z = 0.4,
}
Magic.cls = "magic"
Magic.fac = Obj.fac..Magic.cls
Cls.add(Magic)

-- static

function Magic.cre(p_pos, p_tilepos)

	local Cls = Magic

	if p_tilepos then p_pos = p_pos + p_tilepos * Map.sq end

	local t_id = Sp.cre(Cls, p_pos)
	return t_id
end

-- script method

function Magic.init(_s)
	
	extend.init(_s, Sp   )
	extend._(   _s, Magic)
end

function Magic.upd(_s, dt)

	_s:act_intrvl(dt)


end

function Magic.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end

	_s:tile__()
	
	_s:del()
end

function Magic.tile__(_s)

	local c_tile = _s:tile()
	local t_tile

	if     c_tile == 0                 then
		t_tile = Magic.magic_tile()

	elseif Magic.is_magic_vnsh(c_tile) then
		t_tile = Tile.emp
		Efct.cre_tile_vnsh()
	end

	map.tile__(_s:pos(), t_tile, Game.map_id(), "ground")
end

-- static

function Magic.tilepos_by_inp_prm(dir_h, prm) -- return tilepos diff
	
	local x, y
	if prm.dir_h == "" then
		x = 1
	elseif ar.in_(prm.dir_h, {"l","r"}) then
		x = 2
		if prm.dir_h_msh_cnt >= 2 then
			x = prm.dir_h_msh_cnt + 1
		end
	end
	if  prm.dir_h == "l"
	or (prm.dir_h == "" and dir_h == ha._("l")) then
		x = -x
	end

	y = prm.dir_v_msh_cnt
	if prm.is_lng then
		y = 1
		x = 0
	end
	if prm.dir_v == "d" then y = -y end
	
	-- local t_tilepos = n.vec(x, y)
	local t_tilepos = n.vec(x, y, nil, "tilepos_by_inp_prm")
	return t_tilepos
end

function Magic.magic_tile()
	local t_tile = Tile.magic_block[Wand.wand001.block_idx]
	return t_tile
end

function Magic.is_magic_vnsh(p_tile)
	
	if p_tile == nil then return _.f end
	
	local ret = _.t
	if ar.in_(p_tile, Tile.magic_vnsh_impsbl) then
		ret = _.f
	end
	return ret
end

