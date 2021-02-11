use <../modules/sinewave_cylinder.scad>

base_diameter = 42;
shade_diameter = base_diameter + 34;

// defaults:
/* boundary(height = 20, diameter = 10, period = 1, amplitude = 0) */

boundaries_j = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 11, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 3, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, period = 19, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 78, amplitude = 2),
  boundary(diameter = base_diameter + 15),
];

boundaries_w= [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 3, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter + 10, period = 27, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 19, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 83, amplitude = 2),
  boundary(diameter = base_diameter + 15),
];

boundaries_i= [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 11, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 27, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 3, amplitude = 8),
  boundary(diameter = base_diameter + 15),
];

boundaries_e= [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 1, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 4, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, period = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 7, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_fm = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 11, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 18, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, period = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 13, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_fd = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 1, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 9, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, period = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 16, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_gs = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 3, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 5, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, period = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 16, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_gm = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, period = 10, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, period = 18, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, period = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, period = 18, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

sinewave_cylinder(boundaries_j);
translate([shade_diameter + 30, 0, 0]) sinewave_cylinder(boundaries_w);
translate([shade_diameter * 2 + 30 * 2, 0, 0]) sinewave_cylinder(boundaries_i);
translate([shade_diameter * 3 + 30 * 3, 0, 0]) sinewave_cylinder(boundaries_e);

translate([0, shade_diameter + 30, 0]) sinewave_cylinder(boundaries_fm);
translate([shade_diameter + 30, shade_diameter + 30, 0]) sinewave_cylinder(boundaries_fd);
translate([shade_diameter * 2 + 30 * 2, shade_diameter + 30, 0]) sinewave_cylinder(boundaries_gs);
translate([shade_diameter * 3 + 30 * 3, shade_diameter + 30, 0]) sinewave_cylinder(boundaries_gm);
