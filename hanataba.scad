include <relativity.scad/relativity.scad>
$fn = 30;

// box(42)
dist = 5;
hole_height = 12;
module hole_set(d, rotate_outer = 0, rotate_inner = 0) {
  // rod(d=2,h=10);
  // outer hexagon
  rotated(rotate_outer) {
    rotated(-30)
      translated(30 * y, [-1, 1] / dist)
        rod(d = d, h = hole_height, $class = "hole");
    rotated(30)
      translated(30 * y, [-1, 1] / dist)
        rod(d = d, h = hole_height, $class = "hole");
    translated(30 * x, [-1, 1] / dist)
      rod(d = d, h = hole_height, $class = "hole");
  }

  // inner triangle
  rotated(rotate_inner) {
    translated(15 * y, [-1] / dist)
      rod(d = d, h = hole_height, $class = "hole");
    rotated(30)
      translated(15 * x, [1] / dist)
        rod(d = d, h = hole_height, $class = "hole");
    rotated(60)
      translated(15 * y, [1] / dist)
        rod(d = d, h = hole_height, $class = "hole");
  }

}
module holes() {
  hole_set(2, rotate_outer = 30, rotate_inner = 180);
  hole_set(2.5);
  rod(d = 2.5, h = hole_height, $class = "hole");
}

module lid() {
  difference() {
    align(bottom)
      rod(d = 17, h = 10);
    rod(d = 15.5, h = 2);
  }
}

difference() {
  difference() {
    colored("pink")
      rod(d = 16, h = 9);
    holes();
    rod(d = 15, h = 8);

  }
  lid();
}
// align(bottom)
// rod(d = 17, h = 10);
// align(top)
// rod(d = 15.5, h = 2);
