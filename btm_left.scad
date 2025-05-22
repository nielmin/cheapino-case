use <modules.scad>
use <plate_left.scad>

$fn = 50;

module mount_holes() {
    translate([0,0,-5])
    linear_extrude(5)
    import("default_holes.svg", center=true);
}

module mount_holes2() {
    translate([0,0,-2.5])
    linear_extrude(2)
    import("heat-inserts.svg", center=true);
}

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

module btm_case() {
    difference() {
        difference() {
            linear_extrude(8)
            offset(r=1.2) base();
            
            translate([0, 0, 1])
            linear_extrude(11) 
            offset(r = 0.5) base();
        };
    top_cutout(3, 0.5);
    };
}

module screw_holes(x,y,z, type) {
 translate([x,y,z])
    rotate([0,180,0])
    if (type == 1) {
        mount_holes2();
    } else {
        mount_holes();
    }
}
module cover(out, out_wall, in, in_wall) {
    translate([0,0,-2])
    difference() {
        linear_extrude(out_wall)
        offset(r=out) base();

        translate([0,0,2])
        linear_extrude(in_wall)
        offset(r=in) base();
    }
}

module final_plate() {
    difference() {
        difference() {
        // Cuts plate border to fit with bottom cover
            lt_plate();
            cover(2.4, 5, 1.1, 4);
        }
        // To accomodate screw heads if using screws
        translate([0,0,-3.5])
        //screw_holes(-1,-5,1);
        #inserts(2,2,4);
    }
}

module btm_cover_scew_holes() {
    difference() {
        difference() {
            cover(2.2, 9, 1.1, 7);
            inserts(2,1,0);        
        }
        thumb_cutout(1);
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


module inserts(ch, cr, cz) {
    color("green") {
        translate([10,1.684,cz])
        cylinder(h=ch,r=cr,center=true);

        translate([-48.1,-6,cz])
        cylinder(h=ch,r=cr,center=true);

        translate([-48.14,13.132,cz])
        cylinder(h=ch,r=cr,center=true);

        translate([-29.27,23.26,cz])
        cylinder(h=ch,r=cr,center=true);

        translate([-10.05,29.6,cz])
        cylinder(h=ch,r=cr,center=true);

        translate([27.85,21.37,cz])
        cylinder(h=ch,r=cr,center=true);
        
        translate([18.7,-18.6,cz])
        cylinder(h=ch,r=cr,center=true);
        
        translate([46.13,-23.33,cz])
        cylinder(h=ch,r=cr,center=true);
        
        translate([43.088,-39.59,cz])
        cylinder(h=ch,r=cr,center=true);
    };
}
rotate([0,180,0]) 
//translate([0,0,2])
final_plate();

//difference() {
//inserts(2,1.5,0);
//#inserts(4,1,0);
//}
//translate([0,0,-4])
//btm_cover_scew_holes();
