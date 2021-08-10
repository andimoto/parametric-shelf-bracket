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


shelfLen = 145;
wallLen = 105;
bracketWidth = 25;
bracketThickness = 10;

wallScrewDia = 5;
shelfScrewDia = 3.5;

cutEdges = true;
edgeShiftShelf = 3;
edgeShiftWall = 3;




module screw(screwDia,len)
{
  cylinder(r=screwDia/2, h=len);
  cylinder(r1=screwDia,r2=screwDia/2,h=5);
}

module screw2(screwDia,len)
{
  cylinder(r=screwDia/2, h=len);
  translate([0,0,3]) cylinder(r1=screwDia,r2=screwDia/2,h=3);
  cylinder(r=screwDia, h=3);
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
    translate([10,30,10+(25-10)/2]) rotate([0,-90,0]) screw(wallScrewDia,wall+5);
    translate([10,90,10+(25-10)/2]) rotate([0,-90,0]) screw(wallScrewDia,wall+5);

    translate([30,10,10+(25-10)/2]) rotate([90,0,0]) screw2(shelfScrewDia,bracketThickness);
    translate([130,10,10+(25-10)/2]) rotate([90,0,0]) screw2(shelfScrewDia,bracketThickness);
  }
}

module shelfbracket()
{
  difference() {
    bracket(shelfLen,wallLen,bracketThickness,bracketWidth);

    if(cutEdges == true)
    {
      translate([shelfLen-edgeShiftShelf,0,0]) rotate([0,45,0])
        cube([bracketWidth,bracketThickness,bracketWidth]);
      translate([shelfLen-edgeShiftShelf,0,bracketWidth]) rotate([0,45,0])
        cube([bracketWidth,bracketThickness,bracketWidth]);

      translate([0,wallLen-edgeShiftWall,0]) rotate([-45,0,0])
        cube([bracketThickness,bracketWidth,bracketWidth]);
      translate([0,wallLen-edgeShiftWall,bracketWidth]) rotate([-45,0,0])
        cube([bracketThickness,bracketWidth,bracketWidth]);
    }
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
