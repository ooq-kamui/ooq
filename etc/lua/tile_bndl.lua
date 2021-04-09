log.scrpt("tile_bndl.lua")

Tile_bndl = {
	
	_ = {
		base_tile = {
			x5x5 = {
				126,      136, 141, 146,
				251, 256, 261, 266, 271,
				376, 381, 386, 391, 396,
				501, 506, 511, 516, 521,
				--[[
				101, 106,      116,
				201, 206,      216,
				301, 306, 311, 316,
				--]]
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
	log._("Tile_bndl.is_base_tile_bndl", p_tile, p_base_tile)
	if not p_tile then return end

	local ret = _.f
	local base_tile

	local t_tile
	for idx = 1, 5 do
		t_tile = p_base_tile + Tile.col_idx_max * (idx - 1)
		log._("is_base_tile_bndl", t_tile, p_tile, t_tile + (5 - 1))
		if t_tile <= p_tile and p_tile <= t_tile + (5 - 1) then
			ret = _.t
			base_tile = p_base_tile
			log._(ret, base_tile)
			break
		end
	end
	log._("is_base_tile_bndl end", ret, base_tile)
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

