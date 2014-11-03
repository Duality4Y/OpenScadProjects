/*
Author: Duality

I made this to allign leds, so I could precisely fix leds in a matrix.
first for making a single 8x8 led matrix. but later for making a led cube.

*/

//matrix width (like how many holes in a row)
matrix_width = 8;
//matrix height. (and how many rows)
//together it makes a led matrix of 8x8 holes.
//if height = width = 8;
matrix_height = 8;
//led diameter
led_d = 5; //diameter for 5mm led
//matrix thickness.
matrix_thickness = 2;

//spacing between leds/holes and offset from edge's
spacing = 1;

module led_col(width, hole_d)
{
	
	//calculate the x position for every led/hole circle.
	function calc_x(variable) = 
		(((variable*hole_d)+variable*spacing)-hole_d/2);
	
	//use a loop to place the cylinders one for one.
	for(i = [1:width])
	{
		translate([calc_x(i), 0, 0])
    circle(r=hole_d/2);
	}
}

module led_row(width, height, hole_d)
{
  function calc_y(variable) = 
    (((variable*hole_d)+variable*spacing)-hole_d/2);
    
  for(i = [1:height])
  {
    translate([0,calc_y(i),0])
    led_col(width, hole_d);
  }
}

module led_matrix(width, height, hole_d)
{
  //calculate the with of the surface to extrude the holes from
  function calc_surface_width() = 
    (width*hole_d+(width*spacing)+spacing);
  //also for the height of that surface.
  function calc_surface_height() = 
    (height*hole_d+(height*spacing)+spacing);
  
  echo("width: ");
  echo(calc_surface_width());
  echo("height: ");
  echo(calc_surface_height());
  
  //make the holes in the sheet
  difference()
  {
    square(calc_surface_width(), calc_surface_height());
    led_row(width, height, hole_d, $fn=50);
  }
}

//led_matrix creates a sheet with holes. and with linear_extrude() we give it
//the desired thickness.
linear_extrude(height=matrix_thickness)
led_matrix(matrix_width, matrix_height, led_d);
