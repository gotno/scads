use <../modules/sinewave_cylinder.scad>

base_diameter = 42;
shade_diameter = base_diameter + 34;

boundaries_j = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 11, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 3, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, cycles = 19, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 78, amplitude = 2),
  boundary(diameter = base_diameter + 15),
];

boundaries_w= [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 3, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 27, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 19, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 83, amplitude = 2),
  boundary(diameter = base_diameter + 15),
];

boundaries_i= [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 11, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 27, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 3, amplitude = 8),
  boundary(diameter = base_diameter + 15),
];

boundaries_e= [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 1, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 4, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, cycles = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 7, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_fm = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 11, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 18, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, cycles = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 13, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_fd = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 1, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 9, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, cycles = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 16, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_gs = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 3, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 5, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, cycles = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 16, amplitude = 4),
  boundary(diameter = base_diameter + 15),
];

boundaries_gm = [
  boundary(height = 15, diameter = base_diameter),
  boundary(height = 22, diameter = base_diameter),
  boundary(height = 22, diameter = shade_diameter, cycles = 10, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter + 10, cycles = 18, amplitude = 8),
  boundary(height = 22, diameter = shade_diameter, cycles = 20, amplitude = 4),
  boundary(height = 22, diameter = shade_diameter, cycles = 18, amplitude = 4),
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
