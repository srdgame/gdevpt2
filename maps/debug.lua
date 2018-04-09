return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 15,
  properties = {},
  tilesets = {
    {
      name = "tileset_dusty_v02",
      firstgid = 1,
      filename = "tilesets/tileset_dusty_v02.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "tilesets/tileset_dusty_v02.png",
      imagewidth = 256,
      imageheight = 160,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {
        {
          name = "dirt",
          tile = -1,
          properties = {}
        },
        {
          name = "tile",
          tile = -1,
          properties = {}
        }
      },
      tilecount = 40,
      tiles = {
        {
          id = 0,
          terrain = { 0, 0, 0, 1 }
        },
        {
          id = 1,
          terrain = { 0, 0, 1, 1 }
        },
        {
          id = 2,
          terrain = { 0, 0, 1, 0 }
        },
        {
          id = 3,
          terrain = { 1, 1, 1, 0 }
        },
        {
          id = 4,
          terrain = { 1, 1, 0, 1 }
        },
        {
          id = 8,
          terrain = { 0, 1, 0, 1 }
        },
        {
          id = 9,
          terrain = { 1, 1, 1, 1 },
          probability = 0.5
        },
        {
          id = 10,
          terrain = { 1, 0, 1, 0 }
        },
        {
          id = 11,
          terrain = { 1, 0, 1, 1 }
        },
        {
          id = 12,
          terrain = { 0, 1, 1, 1 }
        },
        {
          id = 16,
          terrain = { 0, 1, 0, 0 }
        },
        {
          id = 17,
          terrain = { 1, 1, 0, 0 }
        },
        {
          id = 18,
          terrain = { 1, 0, 0, 0 }
        },
        {
          id = 19,
          terrain = { 1, 1, 1, 1 },
          probability = 0.25
        },
        {
          id = 20,
          terrain = { 1, 1, 1, 1 },
          probability = 0.25
        },
        {
          id = 27,
          terrain = { 0, 0, 0, 0 },
          probability = 0.5
        },
        {
          id = 28,
          terrain = { 0, 0, 0, 0 },
          probability = 0.5
        }
      }
    },
    {
      name = "tileset_mining_v01",
      firstgid = 41,
      filename = "tilesets/tileset_mining_v01.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "tilesets/tileset_mining_v01.png",
      imagewidth = 160,
      imageheight = 96,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 15,
      tiles = {
        {
          id = 0,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 5.875,
                y = 0.875,
                width = 20,
                height = 30.125,
                rotation = 0,
                visible = true,
                properties = {
                  ["collidable"] = true
                }
              }
            }
          }
        },
        {
          id = 5,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 5,
                y = 0.25,
                width = 22.125,
                height = 31.75,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 6,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 3.25,
                y = 4.375,
                width = 19.5,
                height = 12.5,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 7,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 6.125,
                width = 27.875,
                height = 19.625,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 8,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 2,
                y = 6.25,
                width = 27.875,
                height = 19.625,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 12,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = -0.125,
                y = 6,
                width = 27,
                height = 19.75,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 13,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 2.125,
                y = 6.125,
                width = 27.875,
                height = 19.75,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        }
      }
    },
    {
      name = "tileset_temple_v01",
      firstgid = 56,
      filename = "tilesets/tileset_temple_v01.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "tilesets/tileset_temple_v01.png",
      imagewidth = 128,
      imageheight = 96,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 12,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "CgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAAoAAAAKAAAACgAAAA=="
    },
    {
      type = "tilelayer",
      name = "Tile Layer 2",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "PQAAAAAAAAAAAAAAAAAAAEAAAABBAAAAAAAAAAAAAAAAAAAAAAAAADgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=="
    },
    {
      type = "objectgroup",
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "open_chest",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "door_board",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "minecart_brown",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "minecart_grey",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "minecart_empty",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "tnt_box",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "crate",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "pickaxe",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "barrel",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "open_chest_deb",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "open_chest_deb",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
