log.scrpt("tile.lua")

Tile = {

	_tile,

}

function Tile.tile__init()


end

function Tile.tile__clr()


end

-- tile

tile = {}

function tile._(tilemap_url, t_layer, x, y) -- alias

	local t_tile = tilemap.get_tile(tilemap_url, t_layer, x, y)
	return t_tile
end

function tile.__(tilemap_url, t_layer, x, y, p_tile) -- alias

	tilemap.set_tile(tilemap_url, t_layer, x, y, p_tile)
end

