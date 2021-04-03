log.scrpt("tile.lua")

Tile = { -- tile num
	emp = 0,
	magic_block = { -- wand block

		1, 2, 3, -- clmb, elv
		-- 15,16, -- clmb
		-- 17,    -- elv

		-- block x1x1
		-- 2,3,4,5,6,7,8,9,10,14,
		4,5,6,7,8,9,10,14,15,16,17,
		-- block 5 x 5
		101, 106,      116,
		201, 206,      216,
		301, 306, 311, 316,
	}, -- enum
	-- wall = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, -- enum
	wall = {4, 5, 6, 7, 8, 9, 10}, -- enum
	-- soil = {1, 13, 123, 223, 228,}, -- enum
	soil = {13, 123, 223, 228,}, -- enum
	wood      = {311,}, -- enum
	wood_burn = {316,}, -- enum
	block = { -- use ??
		1, 400, -- min, max
	},
	block_excld = {
		1, 2, 3,
		-- 15, 16, 17,
	},
	-- clmb = {15, 16}, -- enum
	clmb = {1, 3}, -- enum
	-- elv_u = {17}, -- enum
	elv_u = {2}, -- enum
	magic_vnsh_impsbl = {45, 65,}, -- enum

	col_idx_max = 20,
}

function Tile.is_clmb(tile)
	local ret = ar.in_(tile, Tile.clmb)
	return ret
end

function Tile.is_elv(p_tile, dir)
	
	dir = dir or "u"
	
	local ret = _.f
	local tile
	if dir == "u" then tile = Tile.elv_u end
	ret = ar.in_(p_tile, tile)
	return ret
end

function Tile.is_block(tile)
	
	if tile == nil then return _.f end
	
	local ret = _.f
	if int.is_rng(tile, Tile.block) and not ar.in_(tile, Tile.block_excld) then 
		-- ^ Tile.block is min max
		ret = _.t
	end
	return ret
end

function Tile.is_wood(tile)

	if tile == 0 then return _.f end
	
	-- log._("Tile.is_wood", tile)

	local ret = _.f

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(tile)
	if is_tile_bndl then tile = base_tile end

	ret = ar.in_(tile, Tile.wood)
	-- log._("Tile.is_wood", ret, is_tile_bndl, base_tile, tile)
	return ret
end

function Tile.is_wood_burn(tile)

	if tile == 0 then return _.f end
	
	local ret = _.f

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(tile)
	if is_tile_bndl then tile = base_tile end

	ret = ar.in_(tile, Tile.wood_burn)
	return ret
end

-- Tile_bndl

Tile_bndl = {
	
	_ = {
		base_tile = {
			x5x5 = {
				101, 106,      116,
				201, 206,      216,
				301, 306, 311, 316,
			},
		},
	},
}

function Tile_bndl.is_tile_bndl(p_tile)
	
	local ret, base_tile = Tile_bndl.is_tile_bndl_x5x5(p_tile)
	return ret, base_tile
end

function Tile_bndl.is_tile_bndl_x5x5(p_tile)

	local ret = _.f
	
	local t_base_tile, base_tile
	for idx, t_base_tile in pairs(Tile_bndl._.base_tile.x5x5) do
		ret, base_tile = Tile_bndl.is_base_tile_bndl(p_tile, t_base_tile)
		if ret then break end
	end
	-- log._("Tile_bndl.is_tile_bndl_x5x5 end", p_tile, ret, base_tile)
	return ret, base_tile
end

function Tile_bndl.is_base_tile_bndl(p_tile, p_base_tile)
	-- log._("Tile_bndl.is_base_tile_bndl", p_tile, p_base_tile)
	if not p_tile then return end

	local ret = _.f
	local base_tile

	local t_tile
	for idx = 1, 5 do
		t_tile = p_base_tile + Tile.col_idx_max * (idx - 1)
		-- log._("is_base_tile_bndl", t_tile, p_tile, t_tile + (5 - 1))
		if t_tile <= p_tile and p_tile <= t_tile + (5 - 1) then
			ret = _.t
			base_tile = p_base_tile
			-- log._(ret, base_tile)
			break
		end
	end
	-- log._("is_base_tile_bndl end", ret, base_tile)
	return ret, base_tile
end

function Tile_bndl.base_tile(p_tile)

	local is_tile_bndl, base_tile = Tile_bndl.is_tile_bndl(p_tile)

	if not is_tile_bndl then return p_tile end

	return base_tile
end

function Tile_bndl.crct_tile(base_tile, arund_val)

	local df = Tile_bndl.arund_val_2_df_x5x5(arund_val)
	
	local crct_tile = Tile_bndl.crct_tile_by_df(base_tile, df)
	return crct_tile
end

function Tile_bndl.crct_tile_by_df(base_tile, df)

	local crct_tile = base_tile + ( Tile.col_idx_max * df.y ) + df.x
	return crct_tile
end

function Tile_bndl.arund_ar_2_arund_val(arund_ar)
	-- log._("arund_ar_2_arund_val")
	-- log.pp("arund_ar", arund_ar)

	if not arund_ar then log._("arund_ar_2_arund_val : prm nil") return end

	local arund_val
	local a = arund_ar

	if              not a[2]
	and    not a[4]      and not a[5]
	and             not a[7] then
		--     
		--  H  
		--     
		arund_val = 020

	elseif          not a[2]
	and    not a[4]      and     a[5]
	and             not a[7] then
		--     
		--  H# 
		--     
		arund_val = 030

	elseif          not a[2]
	and        a[4]      and     a[5]
	and             not a[7] then
		--     
		-- #H# 
		--     
		arund_val = 070

	elseif          not a[2]
	and        a[4]      and not a[5]
	and             not a[7] then
		--    
		-- #H 
		--    
		arund_val = 060

	elseif          not a[2]
	and    not a[4]      and not a[5]
	and                 a[7] then
		--     
		--  H  
		--  #  
		arund_val = 022

	elseif          not a[2]
	and    not a[4]      and     a[5]
	and                 a[7] then
		--     
		--  H# 
		--  #. 
		arund_val = 032

	elseif          not a[2]
	and        a[4]      and     a[5]
	and                 a[7] then
		--     
		-- #H# 
		-- .#. 
		arund_val = 072

	elseif          not a[2]
	and        a[4]      and not a[5]
	and                 a[7] then
		--    
		-- #H 
		-- .# 
		arund_val = 062

	elseif              a[2]
	and    not a[4]      and not a[5]
	and                 a[7] then
		--  #  
		--  H  
		--  #  
		arund_val = 222

	elseif              a[2]
	and    not a[4]      and     a[5]
	and                 a[7] then
		--  #. 
		--  H# 
		--  #. 
		arund_val = 232

	elseif              a[2]
	and        a[4]      and     a[5]
	and                 a[7] then
		-- .#. 
		-- #H# 
		-- .#. 
		arund_val = 272

	elseif              a[2]
	and        a[4]      and not a[5]
	and                 a[7] then
		-- .# 
		-- #H 
		-- .# 
		arund_val = 262

	elseif              a[2]
	and    not a[4]      and not a[5]
	and             not a[7] then
		--  #  
		--  H  
		--     
		arund_val = 220
		
	elseif              a[2]
	and    not a[4]      and     a[5]
	and             not a[7] then
		--  #. 
		--  H# 
		--     
		arund_val = 230

	elseif              a[2]
	and        a[4]      and     a[5]
	and             not a[7] then
		-- .#. 
		-- #H# 
		--     
		arund_val = 270

	elseif              a[2]
	and        a[4]      and not a[5]
	and             not a[7] then
		-- .# 
		-- #H 
		--    
		arund_val = 260
	end

	-- log._("arund_ar_2_arund_val end", arund_val)
	return arund_val
end

function Tile_bndl.arund_val_2_df_x5x5(arund_val)

	local x, y

	-- 020  030  070  060
	--                   
	--  H    H#  #H#  #H 
	--                   
	---------------------
	-- 022  032  072  062
	--                   
	--  H    H#  #H#  #H 
	--  #    #.  .#.  .# 
	---------------------
	-- 222  232  272  262
	--  #    #.  .#.  .# 
	--  H    H#  #H#  #H 
	--  #    #.  .#.  .# 
	---------------------
	-- 220  230  270  260
	--  #    #.  .#.  .# 
	--  H    H#  #H#  #H 
	--                   
	---------------------

	if     arund_val == 020 then x = 0; y = 0
	elseif arund_val == 030 then x = 1; y = 0
	elseif arund_val == 070 then x = 2; y = 0
	elseif arund_val == 060 then x = 3; y = 0
	
	elseif arund_val == 022 then x = 0; y = 1
	elseif arund_val == 032 then x = 1; y = 1
	elseif arund_val == 072 then x = 2; y = 1
	elseif arund_val == 062 then x = 3; y = 1
	
	elseif arund_val == 222 then x = 0; y = 2
	elseif arund_val == 232 then x = 1; y = 2
	elseif arund_val == 272 then x = 2; y = 2
	elseif arund_val == 262 then x = 3; y = 2
	
	elseif arund_val == 220 then x = 0; y = 3
	elseif arund_val == 230 then x = 1; y = 3
	elseif arund_val == 270 then x = 2; y = 3
	elseif arund_val == 260 then x = 3; y = 3
	end
	
	local df = {x = x, y =y}
	return df
end

tile = {}

function tile.__(tilemap_url, t_layer, x, y, p_tile)
	
	return tilemap.set_tile(tilemap_url, t_layer, x, y, p_tile)
end
