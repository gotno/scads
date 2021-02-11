// first element is bottom of model, last is top of model.
boundaries = [
  boundary(),
  boundary(),
  boundary(),
];

sinewave_cylinder(boundaries);

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
function boundary(height = 20, diameter = 10, period = 1, amplitude = 0) =
  [height, boundary_polygon_points(diameter, period, amplitude)];

// returns a vector of vectors defining all points in a boundary polygon
function boundary_polygon_points(diameter, period, amplitude) =
  let(radius = diameter / 2)
    [for(t = [0:4:360]) sine_wave_point_on_circle(radius, period, amplitude, t)];

// returns [x,y] point at theta for sin wrapped on circle with radius    
function sine_wave_point_on_circle(radius, period, amplitude, theta) = [
  (radius + amplitude * sin(period * theta)) * cos(theta),
  (radius + amplitude * sin(period * theta)) * sin(theta)
]; 

// takes two boundaries, hulls them together pie slice by pie slice,
// and renders them raised on the z axis by z_offset
module segment(bottom_boundary, top_boundary, z_offset) {  
  points_bottom = bottom_boundary[1];
  points_top = top_boundary[1];

  height = bottom_boundary[0];

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
