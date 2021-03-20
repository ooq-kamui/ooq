log.scrpt("block.lua")

Block = {
	tile = Tile.magic_block,
	act_intrvl_time = 3, -- 7, -- 20,
}
Block.name_idx_max = #Block.tile

Block.cls = "block"
Block.fac = Obj.fac..Block.cls
Cls.add(Block)

Block.gold = {}
for idx, tile in pairs(Tile.magic_block) do
	Block.gold[ha._("block"..int.pad(tile))] = 10
end

-- static

function Block.cre(pos, p_tile)
	-- log._("block.cre p_tile", p_tile)
	
	p_tile = p_tile or rnd.ar(Tile.magic_block)

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(p_tile)
	if is_tile_bndl then p_tile = base_tile end
	
	-- log._("block.cre p_tile", p_tile)
	
	local Cls = Block
	prm = {}
	prm.name = ha._(Block.cls..int.pad(p_tile))
	prm.tile = p_tile
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Block.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Block)
end

function Block.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_static(dt)

	_s:upd_final()
end

function Block.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	_s:trnsf_tile()
end

function Block.trnsf_tile(_s)
	
	if _s._hld_id then return end

	local foot_o_tile = _s:foot_o_tile()
	if not (
	   Tile.is_block(foot_o_tile)
	or Tile.is_clmb(foot_o_tile)
	or Tile.is_elv(  foot_o_tile)
	) then return end
	
	_s._is_trnsf_tile = _.t
	_s:del()
end

function Block.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
end

function Block.final(_s)
	-- u.log("Block.final()")
	
	Sp.final(_s)
	Hldabl.final(_s)

	if _s._is_trnsf_tile then
		_s:tile__(_s._tile)
	end
end

