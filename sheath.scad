include <relativity.scad/relativity.scad>
$fn = 20;

module base() {
  minkowski() {
    box([30, 80, 4]);
    cylinder(0.5, r = 4);
  }
}

module inside() {
  box([32.5, 80, 2.4]) {
    align([0, 1, 1])
      box([$parent_size.x * 0.75, $parent_size.y * 0.95, $parent_size.z * 1], anchor = [0, 1, 0]);
    translated([0, -20, 0])
      translated(6 * x, [1, -1])
        rod(r = 0.95, h = 10)
          rod(r = 2.5, h = 3.4);
    translated(15 * y)
      rod(r = 0.95, h = 10)
        rod(r = 2.5, h = 3.4);
  }
}

difference() {
  base();
  translate([0, 4.01, 0.4])
    inside();
}
