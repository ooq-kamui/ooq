log.scrpt("magic.lua")

Magic = {
	act_intrvl_time = 0.1,
	name_idx_max = 1,
	z = 0.4,
}
Magic.cls = "magic"
-- Magic.fac = Magic.cls.."Fac" -- old
Magic.Fac = Obj.fac..Magic.cls
Cls.add(Magic)

-- static

function Magic.cre(pos, tilepos)

	local Cls = Magic

	if tilepos then pos = pos + tilepos * Map.sq end

	local id = Sp.cre(Cls, pos)
	return id
end

-- script method

function Magic.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Magic)
end

function Magic.upd(_s, dt)

	_s:act_intrvl(dt)


end

function Magic.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	local pos  = _s:pos()
	local tile = _s:tile()
	-- log._("tile", tile, pos)

	if tile == 0 then
		map.tile__(pos, Magic.magic_tile(), Game.map_id(), "ground", "ground")

	elseif Magic.is_magic_vnsh(tile) then
		map.tile__(pos, Tile.emp, Game.map_id(), "ground", "ground")
	end
	
	_s:del()
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
	if prm.dir_h == "l" or (prm.dir_h == "" and dir_h == ha._("l")) then x = -x end

	y = prm.dir_v_msh_cnt
	if prm.is_lng then
		y = 1
		x = 0
	end
	if prm.dir_v == "d" then y = -y end
	
	local tilepos = n.vec(x, y)
	return tilepos
end

function Magic.magic_tile()
	local tile = Tile.magic_block[Wand.wand001.block_idx]
	return tile
end

function Magic.is_magic_vnsh(tile)
	
	if tile == nil then return _.f end
	
	local ret = _.t
	if ar.in_(tile, Tile.magic_vnsh_impsbl) then
		ret = _.f
	end
	return ret
end

