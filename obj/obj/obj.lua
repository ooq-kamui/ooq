log.scrpt("obj.lua")

Obj = {}
Obj.fac = "objFac#"

-- tst

Obj.tst = {}
-- Obj.fall = {}

function Obj.tst.tst()
	local Cls = {
		Chara,
		Block,
		Anml,
		Seed,
		Kagu,
		Plant,
		Bush, Bush,
		Mshrm, Mshrm, Mshrm,
		Fluff, Fluff,
		Flower, Flower,
		Dish, Dish, Dish, Dish, Dish, Dish,
	}
	Obj.tst._(Cls)
end

function Obj.tst.chara()
	local Cls = {
		Chara,Chara,Chara,Chara,Chara,Chara,
		Chara,Chara,Chara,Chara,Chara,Chara,
		Seed,Seed,Seed,Seed,
	}
	Obj.tst._(Cls)
end

function Obj.tst.fire()
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Fire,Fire,Fire,Fire, -- Fire,Fire,
		Seed, -- Seed,Seed,Seed,Seed,
		Wood,Wood,Wood,Wood,Wood,
		Leaf,Leaf,Leaf,
		Dryleaf,Dryleaf,Dryleaf,Dryleaf,Dryleaf,
	}
	Obj.tst._(Cls)
end

function Obj.tst.tree()
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
	}
	Obj.tst._(Cls)
end

function Obj.tst.game_start()
	
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Anml,Anml,Anml,Anml,Anml,Anml,Anml,Anml,
		---[[
		Flower,Flower,Flower,Flower,
		Veget,Veget,Veget,Veget,Veget,Veget,
		Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,
		Plant,Plant,Plant,
		Tree,Tree,Tree,Tree,Tree,Tree,
		Fruit,Fruit,Fruit,Fruit,Fruit,
		Egg,Egg,Egg,Egg,Egg,Egg,Egg,Egg,Egg,
		Fish,Fish,Fish,Fish,
		Dish,Dish,Dish,
		Dairy,Dairy,Dairy,
		Meat,Meat,Meat,
		Fruit,Fruit,Fruit,
		Wood,Wood,Wood,Wood,
		Leaf,Leaf,Leaf,
		Dryleaf,Dryleaf,Dryleaf,Dryleaf,
		Kagu,Kagu,Kagu,Kagu,Kagu,Kagu,
		Grave,
		Phantom,
		Fire,
		Door,Door,
		-- Block,Block,Block,Block,Block,
		--]]
	}
	Obj.tst._(Cls)
end

function Obj.tst._(p_Cls)
	
	local pos = n.vec(-800, 200)
	local y, idx
	local cnt = 1
	local pos_ini = n.vec(pos.x, pos.y)
	local rng = Game.map_rng_pos()
	while #p_Cls > 0 do
		idx = rnd.int(1, #p_Cls)
		p_Cls[idx].cre(pos, nil)
		ar.del_by_idx(p_Cls, idx)
		pos.x = pos.x + Map.sq
		if pos.x > rng.max.x - Map.verge then
			pos.x = pos_ini.x + cnt * 10
			cnt = cnt + 1
		end
		y = rnd.int(0, 1)
		pos.y = pos.y + Map.sq * y
	end
end

