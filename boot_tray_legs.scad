$fn = 256;

function line(point1, point2, width = 1) =

let(angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0])))

let(offset_x = 0.5 * width * cos(angle), offset_y = 0.5 * width * sin(angle))

let(offset1 = [-offset_x, offset_y], offset2 = [offset_x, -offset_y])

// [P1a, P2a, P2b, P1b]
[point1 + offset1, point2 + offset1, point2 + offset2, point1 + offset2];

module polyline(points, width = 1) {
  total = len(points) - 1;
  for(index = [0:total - 1]) {
    p1 = points[index];
    p2 = points[index + 1];
    sq = line(p1, p2, width);
    polygon(points = sq);
    if (index != total - 1) {
      p3 = points[index + 2];
      sq2 = line(p2, p3, width);
      // infill
      polygon(points = [sq[2], sq2[3], sq[1], sq2[0]]);
    }

    echo(p1)
      echo(p2)
        translate(p1)
          circle(d = width);
    translate(p2)
      circle(d = width);
  }
}

lip_height = 29.70;
line = [
  [0, 22.5],
  [0.95, lip_height-2],
  [1.5, lip_height-1],
  [2, lip_height],
  [9, lip_height],
  [10, lip_height-2],
  [12, 21.95],
  [21.26, 1.25]
];
cutoff = [
  [-1.95, lip_height],
  [10.70, lip_height],
  [12.60, 21.95],
  [21.26, -1]
];
base = [
  [19.50, 3.1],
  [27, 3.1]
];
leg = [
  [0, 0],
  [5, 0],
  [7, 0],
  [7, 0.5],
  [0.5, 12],
  [-2, 12]
];
module mink_leg() {
  scale([1, 1.4]) {
  minkowski() {
    difference() {
      polygon(leg);
      translate(v = [6.5, 8])
        circle(7);
    }
    circle(r = 0.2);
  }
    }
}

module stem() {

  minkowski() {
    union() {
      difference() {
        difference() {
          minkowski() {
            polyline(line, width = 10);
            circle(r = 0.5);
          }
          minkowski() {
            polyline(line, width = 2);
            circle(r = 0.2);
          }
        }
        translate([23, -2, 0])
          circle(4);
        translate([1, 2, 0])
          polyline(cutoff, width = 4);
      }
      polyline(base, width = 1);
    }
    circle(r = 0.2, $fn = 16);
  }
}
module leg() {
}

translate([0, 5, 15])
rotate_extrude(angle = 125, convexity = 10, $fn = 256)
translate([42, 0, 0])
  mirror([1, 0, 0])
    union() {
      stem();
      translate([19.5, 3.25, 0])
        mirror([0, 1])
          mink_leg();
    }
stem();
