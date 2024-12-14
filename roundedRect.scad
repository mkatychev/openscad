//For a cube set taper to 0
module roundedCube(width, len, height, taper, rounding) {
  pos = [width, len];
  hull() {
    //Bottom
    roundedRectangle(concat(pos, 0), rounding);

    //Top
    roundedRectangle(concat(pos, height), rounding, taper);
  }
}

module roundedRectangle(size, radius, frontTaper = 0) {
  echo(concat(size, 1));
  x = size.x / 2;
  y = size.y / 2;
  z = size.z;
  half_rad = radius / 2;

  hull() {
    cornerSphere([-x + half_rad, -y + half_rad - frontTaper, z], radius);
    cornerSphere([x - half_rad, -y + half_rad - frontTaper, z], radius);
    cornerSphere([-x + half_rad, y - half_rad, z], radius);
    cornerSphere([x - half_rad, y - half_rad, z], radius);
  }
}

module cornerSphere(location, radius) {
  translate(location)
    sphere(r = radius);
}

roundedCube(10, 10, 10, 5, 5);
