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
    value: "forest"
    type: PROPERTY_TYPE_HASH
  }
  properties {
    id: "_tilesize"
    value: "192.0, 144.0, 0.0"
    type: PROPERTY_TYPE_VECTOR3
  }
  properties {
    id: "_mv_rng_pos_algn"
    value: "d"
    type: PROPERTY_TYPE_HASH
  }
}
components {
  id: "forest"
  component: "/assets/map/area/grassy/bg/forest/forest.tilemap"
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
