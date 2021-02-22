-- print("require.lua")

require("assets/etc/lua/_")
require("assets/etc/lua/log")
require("assets/etc/lua/ha")
require("assets/etc/lua/u")
require("assets/etc/lua/int")
require("assets/etc/lua/num")
require("assets/etc/lua/str")
require("assets/etc/lua/n") --  new alias
require("assets/etc/lua/vec")
require("assets/etc/lua/pos")
require("assets/etc/lua/id")
require("assets/etc/lua/extend")
require("assets/etc/lua/pst")
require("assets/etc/lua/url")
require("assets/etc/lua/clct")
require("assets/etc/lua/ar")
require("assets/etc/lua/rnd")
require("assets/etc/lua/ts")
require("assets/etc/lua/cls")
require("assets/etc/lua/map")
require("assets/etc/lua/fac")
require("assets/etc/lua/nd")
require("assets/etc/lua/nd_anm")
require("assets/etc/lua/nd_ar")
require("assets/etc/lua/xy")
require("assets/etc/lua/page")

require("assets/sys/etc/disp")
require("assets/sys/sys/sys")
require("assets/sys/sq/title/title")
require("assets/sys/sq/game/game")
require("assets/sys/sq/game/plyr")

require("assets/sys/sq/game/ply_data/ply_data")
require("assets/sys/sq/game/ply_data/etc/reizoko")
require("assets/sys/sq/game/ply_data/etc/kzn")
require("assets/sys/sq/game/ply_data/etc/zu")
require("assets/sys/sq/game/ply_data/etc/gold")
require("assets/sys/sq/game/ply_data/etc/cfg")

require("assets/sys/file/file")
-- require("assets/sys/file/ply_slt") 
require("assets/sys/file/ply_data")
require("assets/sys/file/map")

require("assets/sys/inp/inp")
require("assets/sys/inp/inp_gui")
require("assets/sys/inp/inp_plyr")

require("assets/etc/msg/msg")
require("assets/etc/ev/ev/ev")
require("assets/etc/ev/wa/wa")
require("assets/etc/ev/scnro/scnro")
require("assets/etc/dia/dia")
require("assets/etc/sound/bgm/bgm")
require("assets/etc/sound/bgm/bgm_bgm")
require("assets/etc/sound/se/se")

require("assets/obj/obj/sp")
require("assets/obj/obj/hldabl")
require("assets/obj/obj/obj")

require("assets/obj/anm/anm")
require("assets/obj/anm/es")

require("assets/etc/lua/tile")
require("assets/etc/lua/dice100")
require("assets/etc/cmr/cmr")

require("assets/map/lua/map")
require("assets/map/lua/map_tile")
require("assets/map/lua/map_obj")

require("assets/map/lua/bg")
require("assets/map/lua/fg")
require("assets/map/lua/mapobj")
require("assets/map/bg/sky/sky")

require("assets/obj/elm/block/block")
require("assets/obj/elm/humus/humus")
require("assets/obj/elm/fire/fire")
require("assets/obj/elm/cloud/cloud")
require("assets/obj/elm/magic/magic")
require("assets/obj/elm/fairy/fairy")
require("assets/obj/elm/warp/warp")

require("assets/obj/itm/itm/wand/wand")
require("assets/obj/itm/itm/wand/wall")

require("assets/obj/itm/gold/gold")
require("assets/obj/itm/food/dairy/dairy")
require("assets/obj/itm/food/dish/dish")
require("assets/obj/itm/food/egg/egg")
require("assets/obj/itm/food/fish/fish")
require("assets/obj/itm/food/fruit/fruit")
require("assets/obj/itm/food/meat/meat")
require("assets/obj/itm/food/veget/veget")
require("assets/obj/itm/food/food")

require("assets/obj/itm/wood/spwood")
require("assets/obj/itm/wood/wood/wood")
require("assets/obj/itm/wood/leaf/leaf")
require("assets/obj/itm/wood/dryleaf/dryleaf")

require("assets/obj/chara/chara/chara")
require("assets/obj/chara/plychara/plychara")
require("assets/obj/chara/emtn/emtn")
require("assets/obj/chara/fuki/fuki/fuki")
require("assets/obj/chara/fuki/serifu")

require("assets/obj/living/livingmove")
require("assets/obj/living/anml/anml")
require("assets/obj/living/flower/flower")
require("assets/obj/living/plant/plant")
require("assets/obj/living/bush/bush")
require("assets/obj/living/mshrm/mshrm")
require("assets/obj/living/seed/seed")
require("assets/obj/living/fluff/fluff")
require("assets/obj/living/tree/tree")
require("assets/obj/living/phantom/phantom/phantom")
require("assets/obj/living/phantom/grave/grave")

require("assets/obj/itm/kagu/kagu/kagu")
require("assets/obj/itm/kagu/reizoko/reizoko")
require("assets/obj/itm/kagu/kitchen/kitchen")
require("assets/obj/itm/kagu/shelf/shelf")
require("assets/obj/itm/kagu/hrvst/hrvst")
require("assets/obj/itm/kagu/pc/pc")
require("assets/obj/itm/kagu/door/door")
require("assets/obj/itm/kagu/flpy/flpy")

-- gui
require("assets/gui/gui/gui/gui")

-- prt
require("assets/gui/prt/prt/prt")
require("assets/gui/prt/prt/prt_base")
require("assets/gui/prt/prt/prt_itm")
require("assets/gui/prt/prt/prt_itm_lst")
require("assets/gui/prt/prt/prt_itm_mtrx")
require("assets/gui/prt/prt/prt_itm_menu")
require("assets/gui/prt/prt/prt_itm_opt")

require("assets/gui/prt/prt/prt_cursor")
require("assets/gui/prt/prt/prt_cursor_mtrx")
require("assets/gui/prt/prt/prt_selected")
require("assets/gui/prt/confirm/confirm")

require("assets/gui/prt/bg/bg")
require("assets/gui/prt/ply_data/ply_data")

-- bag
require("assets/gui/gui/bag/_/bag_gui")
require("assets/gui/gui/bag/prt/bag_prt/bag_prt")
require("assets/gui/gui/bag/prt/bag_prt/bag_prt_itm")

require("assets/gui/gui/bag/prt/inf/bag_inf")
require("assets/gui/gui/bag/prt/itm/bag_itm")
require("assets/gui/gui/bag/prt/block/bag_block")
require("assets/gui/gui/bag/prt/wall/bag_wall")

-- title
require("assets/gui/gui/title/_/title_gui")
require("assets/gui/gui/title/prt/logo/logo")
require("assets/gui/gui/title/prt/ply_slt/ply_slt")

-- flpy
require("assets/gui/gui/flpy/_/flpy_gui")
require("assets/gui/gui/flpy/prt/flpy/flpy")

-- door
require("assets/gui/gui/door/_/door_gui")
require("assets/gui/gui/door/prt/door/door")

-- pc
require("assets/gui/gui/pc/_/pc_gui")
require("assets/gui/gui/pc/prt/pc/pc")
require("assets/gui/gui/pc/prt/cfg/cfg")
require("assets/gui/gui/pc/prt/kzn/kzn")
require("assets/gui/gui/pc/prt/shop/shop/shop")
require("assets/gui/gui/pc/prt/shop/block/block")
require("assets/gui/gui/pc/prt/shop/flower/flower")
require("assets/gui/gui/pc/prt/shop/kagu/kagu")
require("assets/gui/gui/pc/prt/shop/kagu_itm/kagu_itm")
require("assets/gui/gui/pc/prt/shop/tree/tree")
require("assets/gui/gui/pc/prt/snn/snn_dtl/snn_dtl")
require("assets/gui/gui/pc/prt/snn/snn_lst/snn_lst")

-- shelf
require("assets/gui/gui/shelf/_/shelf_gui")
require("assets/gui/gui/shelf/prt/shelf/shelf")
require("assets/gui/gui/shelf/prt/anml/zu_anml")
require("assets/gui/gui/shelf/prt/dish/zu_dish")
require("assets/gui/gui/shelf/prt/flower/zu_flower")

require("assets/gui/gui/dia/_/dia_gui")
require("assets/gui/gui/dia/prt/dia/dia")

require("assets/gui/gui/msg/_/msg_gui")
require("assets/gui/gui/msg/prt/msg/msg")

require("assets/gui/gui/reizoko/_/reizoko_gui")
require("assets/gui/gui/reizoko/prt/reizoko/reizoko")

-- mstr
require("assets/sys/mstr/mstr")
require("assets/sys/mstr/anml")
require("assets/sys/mstr/chara")
require("assets/sys/mstr/kzn")

-- require("assets/sys/mstr/price/price")
require("assets/sys/mstr/flower")
require("assets/sys/mstr/tree")
require("assets/sys/mstr/kagu_itm")
require("assets/sys/mstr/kagu")

-- cfg
require("assets/sys/cfg/cfg")
