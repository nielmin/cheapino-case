use <modules.scad>
use <plate_left.scad>

$fn = 50;

module mount_holes() {
    translate([0,0,-5])
    linear_extrude(5)
    import("default_holes.svg", center=true);
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

module btm_cover_w_tc() {
    difference() {
        difference() {
            cover(2.2, 7.5, 1.1, 6.5);
        }
        thumb_cutout(1);
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

//module btm_cover_w_cutouts() {
//    difference() {
//        difference(){
//            btm_cover_scew_holes();
//            //translate([0,0,-0.8]) rj45_sm();
//        }
//        //translate([0,0,-1])
//        //switches(1); 
//    }
//};

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

btm_cover_w_tc();