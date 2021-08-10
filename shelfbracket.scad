/* shelfbracket.scad
Author: andimoto@posteo.de
*/


$fn=50;

points = [
  [4,0],
  [10,0],
  [0,10],
  [0,4]
];



screwR = 5 /2;
screw2R = 3.5 /2;

module screw(R,len)
{
  cylinder(r=R, h=len);
  cylinder(r1=R*2,r2=R,h=5);
}

module screw2(R,len)
{
  cylinder(r=R, h=len);
  translate([0,0,3]) cylinder(r1=R*2,r2=R,h=3);
  cylinder(r=R*2, h=3);
}



module bracket(l1,l2,wall,h)
{
  difference()
  {
    union()
    {
      cube([l1,wall,h]);
      cube([wall,l2,h]);
    }
    translate([10,30,10+(25-10)/2]) rotate([0,-90,0]) screw(screwR,wall+5);
    translate([10,90,10+(25-10)/2]) rotate([0,-90,0]) screw(screwR,wall+5);

    translate([30,10,10+(25-10)/2]) rotate([90,0,0]) screw2(screw2R,10);
    translate([130,10,10+(25-10)/2]) rotate([90,0,0]) screw2(screw2R,10);
  }
}

module shelfbracket()
{
  difference() {
    bracket(145,105,10,25);
    translate([150-sqrt(10^2+10^2)/2,0,0]) rotate([0,45,0]) cube([10,10,10]);
    translate([0,110-sqrt(10^2+10^2)/2,0]) rotate([-45,0,0]) cube([10,10,10]);

    translate([150-sqrt(10^2+10^2)/2,0,25]) rotate([0,45,0])  cube([10,10,10]);
    translate([0,110-sqrt(10^2+10^2)/2,25]) rotate([-45,0,0]) cube([10,10,10]);
  };

  translate([10,10,0])
  scale([13,9,1])
  difference() {
    linear_extrude(height = 10, center = false, convexity = 0, twist = 0)
      polygon(points);
    linear_extrude(height = 10, center = false, convexity = 0, twist = 0)
      offset(delta = -1) polygon(points);
  };

}

/* */
shelfbracket();
