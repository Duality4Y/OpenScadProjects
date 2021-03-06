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
//hole resolution
$fn=100;

module hole_matrix(width, height, hole_d)
{
	//calculate the x position for every led/hole circle.
	function calc_x(variable) = 
		( ( (variable*hole_d)+variable*spacing)-hole_d/2);
	//calculate the y position for ever led/hole circle.
	function calc_y(variable) = 
    	( ( (variable*hole_d)+variable*spacing)-hole_d/2);
	for(y = [0:height-1])
	{
		for(x = [0:width-1])
		{
			translate([calc_x(x), calc_y(y)+height, 0])
			circle(r=hole_d/2);
		}
	}
}

//led_matrix creates a sheet with holes. and with linear_extrude() we give it
//the desired thickness.
linear_extrude(height=matrix_thickness)
led_matrix(matrix_width, matrix_height, led_d);
