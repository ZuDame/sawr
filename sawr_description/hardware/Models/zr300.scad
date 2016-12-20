// Basic Model of Intel(R) RealSense(TM) ZR300 Depth Camera
//   also includes cutting plan for basic mounting
// Developed b0y: Michael McCool
// Copyright 2016 Intel Corporation
// License: CC-BY.  See LICENSE.md

// All units in mm unless noted otherwise.

sm_base = 10;  // "smoothness" of curves; larger->smoother
mount_hole_sm = sm_base;
m2_5_hole_radius = 2.5/2;

// CAMERA PARAMETERS

// basic overall size of camera
zr300_x = 156;
zr300_y = 9.5;
zr300_z = 32.5;

// base of camera
zr300_base_x1 = 32;
zr300_base_x2 = 57;
zr300_base_z = 3;
zr300_base_h = 18; // separation of mounting holes
zr300_base_r = m2_5_hole_radius;

// thickness of magnetic mounting plate and tape
zr300_plate_thick = 1.4;

// CAMERA MOUNT PARAMETERS

// defaults 
zr300_mount_hole_t = 0.2;  // tolerance of mounting hole
zr300_mount_slot_t = 0.0;  // tolerance of mounting slot

// ZR300 Camera Model (3D)
module zr300_camera() {
  color([0.1,0.1,0.7,0.9])
  translate([-zr300_x/2,-zr300_y-zr300_plate_thick,0]) {
    cube([zr300_x,zr300_y,zr300_z]);
    difference() {
      hull() {
        translate([zr300_x/2-zr300_base_x2/2,0,0])
          cube([zr300_base_x2,zr300_y,0.1]);
        translate([zr300_x/2-zr300_base_x1/2,0,-zr300_base_z])
          cube([zr300_base_x1,zr300_y,0.1]);
      }
      translate([0,zr300_y/2,-zr300_base_z-0.1]) {
        translate([zr300_x/2-zr300_base_h/2,0,0])
          cylinder(r=zr300_base_r,h=zr300_base_z,$fn=mount_hole_sm);
        translate([zr300_x/2+zr300_base_h/2,0,0])
          cylinder(r=zr300_base_r,h=zr300_base_z,$fn=mount_hole_sm);
      }
    }
  }
}

// ZR300 Camera Mount Slot (2D)
module zr300_camera_mounting_holes(
  hole_t = zr300_mount_hole_t,
  slot_t = zr300_mount_slot_t
) {
}

// VISUALIZATION
zr300_camera();
translate([0,zr300_y+3.5,0])
  rotate([90,0,0])
    linear_extrude(3)
      zr300_camera_mounting_holes();