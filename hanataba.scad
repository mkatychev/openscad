include <relativity.scad/relativity.scad>
$fn = 128;

// box(42)
dist = 5;
hole_height = 12;
module hole_set(d, rotate_outer = 0, rotate_inner = 0) {
  // rod(d=2,h=10);
  // outer hexagon
  outer_dist = 28.5;
  rotated(rotate_outer) {
    rotated(-30)
      translated(outer_dist * y, [-1, 1] / dist)
        rod(d = d, h = hole_height, $class = "hole");
    rotated(30)
      translated(outer_dist * y, [-1, 1] / dist)
        rod(d = d, h = hole_height, $class = "hole");
    translated(outer_dist * x, [-1, 1] / dist)
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

module hanataba(holes = true) {

  translated([0,0,-2])
  difference() {
    colored("pink")
      rod(d = 16.5, h = 9);
    if (holes) {
      holes();
      rod(d = 15, h = 8);
    }

  }
}

module bottom_lip(top_d = 15.5) {
  union() {
  align(bottom)
    rod(d = 17, h = 10)
      translate([0,0,-.001])
      align(top)
        rod(d = top_d, h = 1.15);
    }
}

module hanataba_top(holes = true, top_d = 15.5) {
  difference() {
    hanataba(holes);
    bottom_lip(top_d);
  }
}

module hanataba_bottom() {
  difference() {
    scale(.999)
    hanataba(holes = true);
      // translate([0,0,.1])
    hanataba_top(holes = false);
    }
}

// scale top lip diameter a bit for tolerance
hanataba_top();
// hanataba_bottom();
// hanataba();
// bottom_lip();
