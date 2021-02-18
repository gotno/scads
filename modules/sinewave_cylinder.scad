// first element is bottom of model, last is top of model.
sinewave_cylinder([
  boundary(height = 10, diameter = 40, cycles = 1, amplitude = 0),
  boundary(height = 10, diameter = 20, cycles = 5, amplitude = 8),
  boundary(height = 10, diameter = 20, cycles = 5, amplitude = 4, phase_shift = 50),
  boundary(height = 10, diameter = 20, amplitude = 0),
]);

module sinewave_cylinder(boundaries) {
  // recurse to sum up the already rendered segment heights
  function current_z_offset(boundary_index = -1, z_offset = 0) =
    let(boundary_height = boundaries[boundary_index][0])
      boundary_index == -1
      ? z_offset
      : current_z_offset(boundary_index - 1, z_offset + boundary_height);

  // render segments
  for(i = [0:len(boundaries) - 2]) {
    segment(boundaries[i], boundaries[i + 1], current_z_offset(i - 1));
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
    height,
    generate_boundary_polygon_points(
      radius,
      cycles,
      amplitude,
      phase_shift_degrees
    )
  ];


// private

function boundary_height(boundary) = boundary[0];
function boundary_polygon_points(boundary) = boundary[1];

// returns a vector of vec2s defining the points in a boundary polygon
function generate_boundary_polygon_points(radius, cycles, amplitude, phase_shift, detail_level = 1) =
  let(
    detail_levels = [0.5, 1, 2, 4, 6, 12, 36],
    step_size = detail_levels[detail_level]
  )
    [for(t = [0:step_size:360]) sine_wave_point_on_circle(radius, cycles, amplitude, t, phase_shift)];

// returns [x,y] point at t for sin wrapped on circle with radius    
function sine_wave_point_on_circle(radius, cycles, amplitude, t, phase_shift) = [
  (radius + amplitude * sin(cycles * t + phase_shift)) * cos(t),
  (radius + amplitude * sin(cycles * t + phase_shift)) * sin(t)
]; 

// takes two boundaries, builds each slice by slice, hulling the top and bottom
// slices together as it goes, then renders them raised on the z axis by z_offset
module segment(bottom_boundary, top_boundary, z_offset) {  
  points_bottom = boundary_polygon_points(bottom_boundary);
  points_top = boundary_polygon_points(top_boundary);

  height = boundary_height(bottom_boundary);

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
