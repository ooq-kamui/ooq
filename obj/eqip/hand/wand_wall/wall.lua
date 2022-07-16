log.scrpt("wall.lua")

Wall = {}

function Wall.__(p_tilepos, wall_idx)

	wall_idx = wall_idx or rnd.ar(Tile.mstr.wall)
	
	local layer = "wall"

	local map_id, game_id = Game.map_id()
	if ha.is_emp(map_id) then return end

	local t_tile
	local tile_crnt = map.tile_6_tilepos_xy(p_tilepos.x, p_tilepos.y, map_id, "wall", layer)
	if tile_crnt == 0 then
		t_tile = Tile.mstr.wall[wall_idx]
		Efct.cre_magic()
	else
		t_tile = 0
		Efct.cre_tile_vnsh()
	end
	
	-- log._("wall __", t_tile)
	map.tile__6_tilepos(p_tilepos, t_tile, map_id, "wall", layer)
end

