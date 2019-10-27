use <Lib/dotSCAD/src/dotscad.scad>
include <Lib/BOSL/constants.scad>
use <Lib/BOSL/shapes.scad>
use <Lib/BOSL/transforms.scad>

$fa = $preview ? 6 : 0.1;
$fs = $preview ? 1 : 0.1;

// 60% Keyboard PCB の定義

// サイズ
pcb_size = [285.000, 94.600];

// マウント用の穴の位置
points_bosses = [
    // from GH60
    [-1 * pcb_size[0] / 2 +  25.200, pcb_size[1] / 2 - 27.900, 0],
    [-1 * pcb_size[0] / 2 + 128.200, pcb_size[1] / 2 - 47.000, 0],
    [     pcb_size[0] / 2 -  24.950, pcb_size[1] / 2 - 27.900, 0],
    [-1 * pcb_size[0] / 2 + 190.500, pcb_size[1] / 2 - 85.200, 0],
    [-1 * pcb_size[0] / 2 +   2.000, pcb_size[1] / 2 - 56.500, 0],
    [     pcb_size[0] / 2 -   2.000, pcb_size[1] / 2 - 56.500, 0],
    // for Tofu?
    [-1 * pcb_size[0] / 2 +  25.200, pcb_size[1] / 2 - 85.200, 0],
    [-1 * pcb_size[0] / 2 + 142.500, pcb_size[1] / 2 - 37.235, 0],
    [     pcb_size[0] / 2 -  24.950, pcb_size[1] / 2 - 85.200, 0]
];

// 60% Keyboard PCB の定義、ここまで

// 板の定義

// 厚さ
thickness = 3.000;

// リセットスイッチの穴
reset_hole = 10.000;

// マウント用の穴（M2 ねじ用穴）（直径）
mount_hole = 2.200;

// 板の定義、ここまで

// 板
module plate() {
    up(thickness / 2)
        difference() {
        /* 波板
            xrot(90)
                corrugated_wall(
                    h=pcb_size[1],
                    l=pcb_size[0],
                    thick=thickness,
                    strut=thickness / 2,
                    orient=ORIENT_X,
                    align=V_CENTER);
        */
        //* 平板
            cube(size=[pcb_size[0], pcb_size[1], thickness], center=true);
        //*/
        
        // リセットスイッチの穴
        move([-1 * pcb_size[0] / 2 + 25.200 + 3.950, -1 * pcb_size[1] / 2 + 27.900 + 20.300, 0.000]) {
            cube(size=[reset_hole, reset_hole, thickness * 2], center=true);
        }
        
        // マウント用穴
        place_copies(points_bosses)
            cyl(l=thickness * 2, r=mount_hole / 2, center=true);
    }
}

plate();