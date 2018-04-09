<?xml version="1.0" encoding="UTF-8"?>
<tileset name="tileset_trees_v01" tilewidth="32" tileheight="32" tilecount="9" columns="3">
 <image source="tileset_trees_v01.png" width="96" height="96"/>
 <terraintypes>
  <terrain name="tree" tile="0"/>
 </terraintypes>
 <wangsets>
  <wangset name="trees" tile="-1">
   <wangedgecolor name="Left Leaves" color="#00ff00" tile="-1" probability="1"/>
   <wangedgecolor name="tree center" color="#0000ff" tile="-1" probability="1"/>
   <wangedgecolor name="Right Leaves" color="#ff7700" tile="-1" probability="1"/>
   <wangedgecolor name="Leaf Connect" color="#00e9ff" tile="-1" probability="1"/>
   <wangtile tileid="0" wangid="0x2030401"/>
   <wangtile tileid="1" wangid="0x4010203"/>
   <wangtile tileid="3" wangid="0x10200"/>
   <wangtile tileid="4" wangid="0x2030000"/>
   <wangtile tileid="6" wangid="0x401"/>
   <wangtile tileid="7" wangid="0x4000003"/>
  </wangset>
 </wangsets>
</tileset>
