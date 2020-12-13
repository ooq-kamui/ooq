log.script("wall.lua")

Wall = {}

function Wall.__(tilepos, wall_idx)

	wall_idx = wall_idx or rnd.ar(Tile.wall)
	
	local layer = "wall"

	local map_id, game_id = Game.map_id()
	if ha.is_emp(map_id) then return end

	local tile
	local tile_crnt = map.tile_by_tilepos(tilepos, map_id, "wall", layer)
	if     tile_crnt == 0 then
		tile = Tile.wall[wall_idx]
	else
		tile = 0
	end
	
	-- log._("wall __", tile)
	map.tile__by_tilepos(tilepos, tile, map_id, "wall", layer)
end
