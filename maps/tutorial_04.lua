return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 27,
  height = 29,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 14,
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
      name = "tileset_temple_v01",
      firstgid = 41,
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
    },
    {
      name = "tileset_mining_v01",
      firstgid = 53,
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
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Floor",
      x = 0,
      y = 0,
      width = 27,
      height = 29,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        28, 29, 28, 29, 28, 29, 28, 29, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 28, 29, 29, 29, 28, 28, 28, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 29, 29, 28, 29, 28, 28, 28, 29, 29, 28, 28, 28, 29, 29, 29, 28, 28, 28, 29, 28, 28,
        28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 28, 29, 28, 29, 28, 29, 29, 29, 29, 28, 28, 29, 29, 28, 29, 28,
        28, 28, 28, 28, 29, 29, 28, 28, 28, 28, 28, 29, 28, 29, 28, 29, 28, 28, 29, 29, 29, 28, 28, 28, 29, 28, 28,
        28, 28, 28, 28, 28, 29, 28, 29, 29, 28, 29, 28, 28, 29, 28, 1, 2, 2, 3, 29, 29, 28, 28, 28, 28, 28, 29,
        28, 28, 28, 28, 29, 28, 28, 28, 28, 1, 2, 2, 2, 2, 2, 13, 10, 20, 12, 3, 28, 28, 28, 28, 29, 29, 29,
        28, 28, 28, 28, 28, 28, 28, 29, 28, 9, 51, 48, 48, 48, 48, 48, 2684354611, 10, 20, 11, 29, 28, 28, 28, 29, 29, 29,
        28, 28, 28, 28, 28, 29, 28, 29, 28, 9, 1610612784, 45, 10, 10, 10, 45, 2684354608, 20, 10, 11, 28, 28, 28, 28, 29, 28, 29,
        28, 28, 28, 29, 29, 28, 29, 28, 28, 9, 1610612784, 10, 10, 10, 10, 10, 2684354608, 10, 4, 19, 28, 28, 28, 28, 29, 29, 29,
        28, 28, 29, 28, 29, 28, 28, 28, 28, 9, 1610612784, 10, 10, 45, 10, 10, 2684354608, 10, 11, 29, 28, 28, 28, 29, 29, 29, 29,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 9, 1610612784, 10, 10, 10, 10, 10, 2684354608, 4, 19, 29, 28, 28, 29, 29, 29, 29, 29,
        28, 28, 28, 29, 28, 28, 29, 29, 29, 9, 1610612784, 45, 10, 10, 10, 45, 2684354608, 11, 28, 28, 28, 28, 29, 28, 29, 29, 29,
        28, 28, 29, 28, 28, 28, 29, 29, 1, 13, 1610612787, 3221225520, 1610612788, 10, 3221225524, 3221225520, 3221225523, 11, 28, 29, 29, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 29, 28, 28, 29, 28, 9, 20, 21, 21, 1610612784, 10, 2684354608, 4, 18, 19, 28, 28, 28, 28, 28, 29, 29, 29, 29,
        28, 29, 28, 28, 28, 28, 29, 29, 9, 10, 10, 20, 1610612784, 10, 2684354608, 11, 29, 28, 29, 28, 28, 29, 29, 29, 28, 29, 29,
        28, 28, 29, 29, 28, 28, 28, 28, 17, 5, 20, 10, 1610612784, 10, 2684354608, 12, 3, 28, 29, 28, 28, 29, 28, 28, 29, 29, 29,
        28, 29, 28, 29, 28, 28, 28, 28, 28, 17, 5, 51, 52, 10, 2684354612, 2684354611, 11, 28, 29, 29, 28, 29, 29, 28, 29, 29, 29,
        28, 29, 28, 28, 28, 28, 28, 29, 28, 29, 9, 1610612784, 10, 10, 10, 2684354608, 11, 28, 29, 28, 28, 29, 28, 28, 29, 29, 29,
        28, 28, 29, 29, 28, 28, 28, 28, 29, 28, 9, 1610612784, 10, 45, 10, 2684354608, 11, 29, 29, 29, 29, 29, 29, 28, 29, 29, 29,
        28, 28, 29, 28, 28, 29, 28, 28, 28, 29, 9, 1610612784, 10, 10, 10, 2684354608, 11, 29, 29, 29, 28, 29, 29, 29, 29, 29, 29,
        28, 28, 29, 28, 28, 28, 28, 29, 28, 29, 9, 1610612787, 3221225520, 3221225511, 3221225520, 3221225523, 12, 3, 28, 28, 28, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 28, 29, 28, 29, 29, 28, 17, 18, 18, 18, 5, 20, 20, 12, 2, 3, 29, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 29, 28, 28, 28, 28, 28, 28, 29, 29, 28, 17, 5, 10, 20, 20, 11, 29, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 29, 28, 29, 29, 29, 28, 28, 28, 29, 29, 28, 17, 18, 18, 18, 19, 28, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 28, 29, 28, 29, 29, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 28, 28, 29, 28, 29, 28, 28, 28, 28, 28, 28, 29, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 28, 28, 29, 28, 29, 29, 29, 29, 29, 29,
        28, 28, 28, 28, 28, 28, 28, 29, 28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29
      }
    },
    {
      type = "tilelayer",
      name = "Detail 1",
      x = 0,
      y = 0,
      width = 27,
      height = 29,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 56, 0, 0, 49, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612777, 0, 0, 0, 0, 0, 2684354601, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 536870961, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 536870962, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225527, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3221225513, 3221225539, 3221225513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354622, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "enemy",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "enemy",
          type = "",
          shape = "point",
          x = 416,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = 0
          }
        },
        {
          id = 2,
          name = "open_chest_deb",
          type = "",
          shape = "rectangle",
          x = 358.667,
          y = 374.667,
          width = 14.6667,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "open_chest_deb",
          type = "",
          shape = "rectangle",
          x = 373.002,
          y = 263.295,
          width = 21.9413,
          height = 13.0603,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "door_board",
          type = "",
          shape = "rectangle",
          x = 416.5,
          y = 673.5,
          width = 30.5,
          height = 25.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 459,
          y = 235,
          width = 9.33333,
          height = 14.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 459,
          y = 235,
          width = 9.33333,
          height = 14.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 395,
          y = 233.667,
          width = 9.33333,
          height = 14.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 330.333,
          y = 332,
          width = 17,
          height = 8.33333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 516.667,
          y = 331.667,
          width = 17,
          height = 8.33333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 459.47,
          y = 680.364,
          width = 9.33333,
          height = 14.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "lamppost",
          type = "",
          shape = "rectangle",
          x = 395.47,
          y = 679.03,
          width = 9.33333,
          height = 14.6667,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      name = "walls",
      x = 0,
      y = 0,
      width = 27,
      height = 29,
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
