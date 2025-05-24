use <modules.scad>;
use <btm_left.scad>;

$fn = 100;

module rj45_socket(is_left) {
    color("cyan") {
        if (is_left==1) {
            translate([29.2, -8.73, 0])
            cube([23,16,10]);
        } else {
            translate([29.2, -10, 0])
            cube([23,16,10]);
        }
    }
}

module mcu_sockets() {
    translate([39.25, 22.7, 0]) 
    cube([19.5, 25,10], center=true);
}

module rotary_encoder() {
    color("cyan") {
    union() {
        translate([39.25, 22.7, 3]) 
        cube([13, 14,6], center=true);
        
        translate([39.25, 15.7, 1]) 
        #cube([7, 4.2,4], center=true);
        
        translate([39.25, 29.7, 1]) 
        #cube([7,4.2,4], center=true);
    }
    }
}

module top_plate(height, offset) {
    // 5 mm for a plate is what I found to be good.
    linear_extrude(height) 
    offset(offset) base();
}

module plate_cutouts(left) {
    hole_column();
    switch_holes();
    rj45_socket(left);
    if (left == 1) {
        rotary_encoder();
    } else {
        mcu_sockets();
    }
}

module lt_plate() {
    difference() {
        difference() {
            top_plate(5, 2.2);
            plate_cutouts(1);
        };
        diodes();
    };
}

//rotate([0,180,0]) 
lt_plate();

