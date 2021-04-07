use <../utils/vector.scad>

// example:
// a boundary defines the transition point between two segments, or the top or
// bottom of the model
//
// boundaries have height, diameter, cycles, amplitude, and phase_shift
//
// height: the distance to the next boundary, if there is one
// diameter: diameter of the midline of the sine wave
// cycles: the number of peaks/troughs 
// amplitude: the height of the peaks and depth of the troughs
// phase_shift: percentage to rotate boundary toward next peak
//  
// first element is bottom of model, last is top of model.
//
// sinewave_cylinder needs at least two boundaries
sinewave_cylinder([
  boundary(height = 10, diameter = 40, amplitude = 0),
  boundary(height = 10, diameter = 20, cycles = 5, amplitude = 8),
  boundary(height = 10, diameter = 20, cycles = 5, amplitude = 4, phase_shift = 50),
  boundary(height = 10, diameter = 20, amplitude = 0),
]);

module sinewave_cylinder(boundary_attributes, detail_level = 1) {
  assert(len(boundary_attributes) > 1, "sinewave cylinder requires at least two boundaries");

  // recurse to sum up the already rendered segment heights
  function current_z_offset(boundaries, boundary_index = -1, z_offset = 0) =
    let(boundary_height = vec_fetch(boundaries[boundary_index], "height"))
      boundary_index == -1
        ? z_offset
        : current_z_offset(boundaries, boundary_index - 1, z_offset + boundary_height);

  // build boundaries
  boundaries = 
    [for(i=[0:len(boundary_attributes) - 1]) [
      ["height", vec_fetch(boundary_attributes[i], "height")],
      ["polygon_points", generate_boundary_polygon_points(
        vec_fetch(boundary_attributes[i], "radius"),
        vec_fetch(boundary_attributes[i], "cycles"),
        vec_fetch(boundary_attributes[i], "amplitude"),
        vec_fetch(boundary_attributes[i], "phase_shift"),
        detail_level
      )]
    ]];

  // render segments
  for(i = [0:len(boundaries) - 2]) {
    segment(boundaries[i], boundaries[i + 1], current_z_offset(boundaries, i - 1));
  }
}

// the bottom or top of the model, or a transition point between two segments
function boundary(height = 1, diameter = 1, cycles = 1, amplitude = 0, phase_shift = 0) =
  let(
    radius = diameter / 2,
    phase_shift_normalized = phase_shift > 99 ? phase_shift % 100 : phase_shift,
    phase_shift_percent = phase_shift_normalized / 100,
    phase_shift_degrees = phase_shift_percent * 360
  )

  [
    ["height", height],
    ["radius", radius],
    ["cycles", cycles],
    ["amplitude", amplitude],
    ["phase_shift", phase_shift_degrees]
  ];

// returns a vector of vec2s defining the [x,y] points in a boundary polygon
function generate_boundary_polygon_points(radius, cycles, amplitude, phase_shift, detail_level) =
  let(
    detail_levels = [0.5, 1, 2, 4, 5, 6, 9, 10, 12, 18, 20],
    step_size = detail_levels[detail_level]
  )
    assert(step_size != undef, str("detail_level must be between 0 and ", len(detail_levels) - 1, "."))
    [for(t = [0:step_size:360]) sine_wave_point_on_circle(radius, cycles, amplitude, t, phase_shift)];

// returns [x,y] point at t for sin wrapped on circle with radius, rotated by phase_shift    
function sine_wave_point_on_circle(radius, cycles, amplitude, t, phase_shift) = [
  (radius + amplitude * sin(cycles * t + phase_shift)) * cos(t),
  (radius + amplitude * sin(cycles * t + phase_shift)) * sin(t)
]; 

// takes two boundaries, builds each slice by slice, hulling the top and bottom
// slices together as it goes, then renders them raised on the z axis by z_offset
module segment(bottom_boundary, top_boundary, z_offset) {  
  points_bottom = vec_fetch(bottom_boundary, "polygon_points");
  points_top = vec_fetch(top_boundary, "polygon_points");

  height = vec_fetch(bottom_boundary, "height");

  for(t = [0:len(points_bottom) - 2]) {
    hull() {
      translate([0, 0, z_offset]) {
        linear_extrude(height = 0.01) {
          polygon([points_bottom[t], points_bottom[t + 1], [0, 0]]);
        }
      }
      translate([0, 0, z_offset + height - 0.01]) {
        linear_extrude(height = 0.01) {
          polygon([points_top[t], points_top[t + 1], [0, 0]]);
        }
      }
    }
  }
};
