log.scrpt("tile.lua")

Tile = { -- tile num
	emp = 0,
	magic_block = { -- wand block, enum

		1, 3, 4, 8, -- clmb
		-- 5,
		6,          -- elv
		7,          -- airflw
		-- 9,          -- mgccrcl

		-- block x1x1
		26, 28,
		-- 27, 29, 30,

		31, 32, 33, 34,
		-- 35, 36, 37, 38, 39, 40, 41,

		-- 51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
		61,
		-- 62, 63, 64, 65, 66, 67, 68, 69,
		-- 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88,
		89, 90, 91, 92, 93, 94,

		-- block 5 x 5
		126,      136, 141, 146,
		251, 256,      266, 271,
		376, 381, 386, 391, 396,
		501, 506, 511,
		626, 631,
	}, -- enum

	soil      = {},     -- enum
	wood      = {280,}, -- enum
	wood_burn = {220,}, -- enum -- tmp
	block = { -- use
		26, 750, -- min, max
	},
	block_excld = {}, -- 1, 2, 3, 18,
	clmb     = {1, 3, 4, 5, 8,}, -- enum
	elv_u    = {6,}, -- enum
	airflw_u = {7,}, -- enum

	warp     = {9,}, -- enum

	magic_vnsh_impsbl = {84, }, -- enum -- tmp

	wall = {1, 2, 11, 12, 21, 22}, -- enum use ?

	-- col_idx_max = 20,
	col_idx_max = 25,
}

function Tile.is_clmb(p_tile)
	local ret = ar.in_(p_tile, Tile.clmb)
	return ret
end

function Tile.is_soil(p_tile)
	local ret = ar.in_(p_tile, Tile.soil)
	return ret
end

function Tile.is_airflw_u(p_tile)
	local ret = ar.in_(p_tile, Tile.airflw_u)
	return ret
end

function Tile.is_elv(p_tile, dir)
	log.flg("Tile.is_elv")
	
	dir = dir or "u"
	
	local ret = _.f
	local t_tile
	if dir == "u" then t_tile = Tile.elv_u end
	ret = ar.in_(p_tile, t_tile)
	return ret
end

function Tile.is_block(p_tile)
	
	if p_tile == nil then return _.f end
	
	local ret = _.f
	if int.is_rng(p_tile, Tile.block) and not ar.in_(p_tile, Tile.block_excld) then 
		-- ^ Tile.block is min max
		ret = _.t
	end
	return ret
end

function Tile.is_wood(p_tile)

	if p_tile == 0 then return _.f end
	
	-- log._("Tile.is_wood", p_tile)

	local ret = _.f

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(p_tile)
	if is_tile_bndl then p_tile = base_tile end

	ret = ar.in_(p_tile, Tile.wood)
	-- log._("Tile.is_wood", ret, is_tile_bndl, base_tile, p_tile)
	return ret
end

function Tile.is_wood_burn(p_tile)

	if p_tile == 0 then return _.f end
	
	local ret = _.f

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(p_tile)
	if is_tile_bndl then p_tile = base_tile end

	ret = ar.in_(p_tile, Tile.wood_burn)
	return ret
end

-- tile

tile = {}

function tile.__(tilemap_url, t_layer, x, y, p_tile)
	
	return tilemap.set_tile(tilemap_url, t_layer, x, y, p_tile)
end

