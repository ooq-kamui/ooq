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

function Block.cre(p_pos, p_tile)
	-- log._("block.cre p_tile", p_tile)
	
	p_tile = p_tile or rnd.ar(Tile.magic_block)
	log._("block.cre p_tile", p_tile)

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(p_tile)
	if is_tile_bndl then p_tile = base_tile end
	
	log._("block.cre p_tile", p_tile)
	
	local t_Cls = Block
	prm = {}
	prm._name   = Block.cls..int.pad(p_tile)
	prm._tile   = p_tile
	local t_id = Sp.cre(t_Cls, p_pos, prm)
	return t_id
end

-- script method

function Block.init(_s)

	extnd._(_s, Sp)
	extnd._(_s, Hldabl)
	extnd._(_s, Block)
end

function Block.__init(_s, prm)
	
	Sp    .__init(_s, prm)
	Hldabl.__init(_s)
end

function Block.upd(_s, dt)
	
	_s:act_intrvl(dt)
	
	_s:upd_pos_static()

	_s:upd_final()
end

function Block.act_intrvl(_s, dt)

	if not _s:is_loop__act_intrvl__(dt) then return end
	
	_s:trnsf__tile()
end

function Block.trnsf__tile(_s)
	
	if _s._hldd_id then return end

	local foot_o_tile = _s:foot_o_tile()
	if not (
	   Tile.is_block(foot_o_tile)
	or Tile.is_clmb(foot_o_tile)
	or Tile.is_elv(  foot_o_tile)
	) then return end
	
	_s._is_trnsf__tile = _.t
	_s:del()
end

function Block.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)
end

function Block.final(_s)
	-- u.log("Block.final()")
	
	Sp    .final(_s)
	Hldabl.final(_s)

	if _s._is_trnsf__tile then
		_s:map_tile__(_s._tile)
	end
end

