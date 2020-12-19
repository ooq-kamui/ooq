components {
  id: "cloud"
  component: "/assets/map/bg/cloud/cloud.tilemap"
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
    id: "_name"
    value: "cloud"
    type: PROPERTY_TYPE_HASH
  }
  properties {
    id: "_tilesize"
    value: "48.0, 48.0, 0.0"
    type: PROPERTY_TYPE_VECTOR3
  }
}
