components {
  id: "script"
  component: "/assets/map/lua/bg.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "_nameHa"
    value: "mountain"
    type: PROPERTY_TYPE_HASH
  }
  properties {
    id: "_tilesize"
    value: "744.0, 186.0, 0.0"
    type: PROPERTY_TYPE_VECTOR3
  }
  properties {
    id: "_mv_rng_pos_algn"
    value: "d"
    type: PROPERTY_TYPE_HASH
  }
}
components {
  id: "mountain"
  component: "/assets/map/area/grassy/bg/mountain/mountain.tilemap"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
