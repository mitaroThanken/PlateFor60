use <Lib/dotSCAD/src/dotscad.scad>
use <Lib/BOSL/shapes.scad>
use <Lib/BOSL/transforms.scad>

$fa = $preview ? 6 : 0.1;
$fs = $preview ? 1 : 0.1;

// 60% Keyboard PCB の定義

// サイズ
pcb_size = [285.00, 94.600];

// マウント用の穴の位置
points_bosses_x = [
    // from GH60
    [-1 * pcb_size[0] / 2 +   2.00, pcb_size[1] / 2 - 56.500, 0],
    [     pcb_size[0] / 2 -   2.00, pcb_size[1] / 2 - 56.500, 0],
];

points_bosses_y_upper = [
    // from GH60
    [-1 * pcb_size[0] / 2 +  25.200, pcb_size[1] / 2 - 27.900, 0],
    [-1 * pcb_size[0] / 2 + 128.200, pcb_size[1] / 2 - 47.00, 0],
    [     pcb_size[0] / 2 -  24.950, pcb_size[1] / 2 - 27.900, 0],
    // for Tofu?
    [-1 * pcb_size[0] / 2 + 142.500, pcb_size[1] / 2 - 37.235, 0],
];

points_bosses_y_lower = [
    // from GH60
    [-1 * pcb_size[0] / 2 + 190.500, pcb_size[1] / 2 - 85.200, 0],
    // for Tofu?
    [-1 * pcb_size[0] / 2 +  25.200, pcb_size[1] / 2 - 85.200, 0],
    [     pcb_size[0] / 2 -  24.950, pcb_size[1] / 2 - 85.200, 0],
];

points_bosses_extra = [
    [-1 * pcb_size[0] / 2 +   5.00, pcb_size[1] / 2 - 5.00, 0],
    [     pcb_size[0] / 2 -   5.00, pcb_size[1] / 2 - 5.00, 0],
    [     pcb_size[0] / 2 -   5.00, pcb_size[1] / 2 - 5.00, 0],
];

// 60% Keyboard PCB の定義、ここまで

// 板の定義

// 厚さ
thickness = 3.00;

// リセットスイッチの穴
reset_hole = 10.00;

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
        move([-1 * pcb_size[0] / 2 + 25.200 + 3.950, -1 * pcb_size[1] / 2 + 27.900 + 20.300, 0.00]) {
            cube(size=[reset_hole, reset_hole, thickness * 2], center=true);
        }
        
        // マウント用穴
        place_copies(points_bosses_x)
            slot(
                p1=[-2.00, 0.00, 0.00],
                p2=[ 2.00, 0.00, 0.00],
                r=mount_hole / 2,
                h=thickness * 2); 
        place_copies(points_bosses_y_upper)
            slot(
                p1=[0.00, -3.00, 0.00],
                p2=[0.00,  1.00, 0.00],
                r=mount_hole / 2,
                h=thickness * 2);
        place_copies(points_bosses_y_lower)
            slot(
                p1=[0.00, -1.00, 0.00],
                p2=[0.00,  3.00, 0.00],
                r=mount_hole / 2,
                h=thickness * 2);
        
        // ねじ止めしない柱（エクストラ）
        place_copies([
            [0,      pcb_size[1] / 2 - 5, 0],
            [0, -1 * pcb_size[1] / 2 + 5, 0],
        ])
            for(x = [-1 * pcb_size[0] / 2 + 12.5 : 10 :  pcb_size[0] / 2 - 12.5])
                xmove(x)
                    slot(
                        p1=[-1.50, 0.00, 0.00],
                        p2=[ 1.50, 0.00, 0.00],
                        r=mount_hole / 2,
                        h=thickness * 2);
        place_copies([
            [-1 * pcb_size[0] / 2 + 2.5,      pcb_size[1] / 2 - 5, 0],
            [-1 * pcb_size[0] / 2 + 2.5, -1 * pcb_size[1] / 2 + 5, 0],
        ])
            slot(
                p1=[-3.00, 0.00, 0.00],
                p2=[ 1.50, 0.00, 0.00],
                r=mount_hole / 2,
                h=thickness * 2);
        place_copies([
            [     pcb_size[0] / 2 - 2.5,      pcb_size[1] / 2 - 5, 0],
            [     pcb_size[0] / 2 - 2.5, -1 * pcb_size[1] / 2 + 5, 0],
        ])
            slot(
                p1=[-1.50, 0.00, 0.00],
                p2=[ 3.00, 0.00, 0.00],
                r=mount_hole / 2,
                h=thickness * 2);
    }
}

plate();