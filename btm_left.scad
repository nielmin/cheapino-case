use <modules.scad>
use <plate_left.scad>

$fn = 50;

module rj45_jack(is_left) {
    color("cyan") {
        if (is_left == 1) {
            translate([29.2, -8.73,-1])
            square([28, 16]);
        } 
        else {
            translate([29.2, -10,-1])
            square([28, 16]);
        }
    }
}

module cover(out, out_wall, in, in_wall) {
    translate([0,0,-2])
    difference() {
        linear_extrude(out_wall)
        offset(r=out) base();

        #translate([0,0,2])
        linear_extrude(in_wall)
        offset(r=in) base();
    }
}

module final_plate() {
    difference() {
        // Cuts plate border to fit with bottom cover
        lt_plate();
        cover(2.4, 5, 1.1, 4);
    }
}

module thumb_cutout(is_left) {
    if (is_left == 1) {
    // right
        translate([47,-8.73,-3])
        cube([22,16,14]);

    } else {
    // left
        translate([47,-10,-3])
        cube([22,16,14]);
    }
}

module rj45_sm() {
    rj_hole();
    translate([0,-11.43,0]) rj_hole();

    // rj 45 housing through holes
    translate([3.1,2,0]) rj_hole();
    translate([3.1,-13.49,0]) rj_hole();
};

//rotate([0,180,0]) 
//translate([0,0,5])
//final_plate();

difference() {
    // 9 mm
    cover(2.2, 9, 1.1, 8);
    thumb_cutout(1);
}